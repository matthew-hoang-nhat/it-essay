import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/remote/model/order/get/address_code.dart';
import 'package:it_project/src/utils/remote/model/order/get/district.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/remote/model/order/get/ward.dart';
import 'package:it_project/src/utils/repository/delivery_repository.dart';
import 'package:it_project/src/utils/repository/delivery_repository_impl.dart';
import 'package:it_project/src/utils/repository/location_repository.dart';
import 'package:it_project/src/utils/repository/location_repository_impl.dart';
import 'package:equatable/equatable.dart';
part 'add_address_state.dart';

enum AddAddressEnum {
  isAllValidated,
  provinces,
  province,
  district,
  ward,
  isLoading,
  street,
  phoneNumber,
  name
}

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit()
      : super(const AddAddressInitial(
          isAllValidated: false,
          provinces: [],
          province: null,
          district: null,
          street: '',
          ward: null,
          districts: null,
          wards: null,
          isLoading: false,
          name: '',
          phoneNumber: '',
          nameAnnouncement: '',
          phoneNumberAnnouncement: '',
          streetAnnouncement: '',
        ));

  final DeliveryRepository _deliveryRepository =
      getIt<DeliveryRepositoryImpl>();
  final LocationRepository _locationRepository =
      getIt<LocationRepositoryImpl>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  _getLocation() async {
    emit(state.copyWithNotAddress(isLoading: true));
    final result = await _locationRepository.getProvinces();
    if (result.isSuccess) {
      final provinces = result.data;

      emit(state.copyWith(
          provinces: provinces,
          district: null,
          districts: [],
          province: null,
          ward: null,
          wards: []));
    }
    emit(state.copyWithNotAddress(isLoading: false));
  }

  initCubit() {
    _getLocation();
  }

  callAPIAddNewAddress() async {
    emit(state.copyWithNotAddress(isLoading: true));

    final newAddress = Address(
      addressCode: AddressCode(
          district: state.district!.code,
          provinceId: state.province!.code,
          street: state.street,
          wardId: state.ward!.code),
      name: state.name,
      phoneNumber: state.phoneNumber,
      address:
          '${state.street}, ${state.ward!.name}, ${state.district!.name}, ${state.province!.name}',
    );
    await _deliveryRepository.addAddress(
      address: newAddress,
    );

    emit(state.copyWithNotAddress(isLoading: false));
  }

  setName(value) {
    emit(state.copyWithNotAddress(name: value));
  }

  setPhoneNumber(value) {
    emit(state.copyWithNotAddress(phoneNumber: value));
  }

  setStreet(value) {
    emit(state.copyWithNotAddress(street: value));
  }

  _checkNameTextField() {
    final name = state.name;
    const nameValidatedAnnouncement =
        'Tên không được chứa số và kí tự đặc biệt';

    if (name.isEmpty) {
      emit(state.copyWithNotAddress(nameAnnouncement: ''));

      return;
    }

    if (name.isNotEmpty && Validate().isInvalidName(name)) {
      emit(state.copyWithNotAddress(
          nameAnnouncement: nameValidatedAnnouncement));

      return;
    }
    emit(state.copyWithNotAddress(nameAnnouncement: ''));
  }

  _checkPhoneNumber() {
    final phoneNumber = state.phoneNumber;
    const phoneNumberValidatedAnnouncement = 'Số điện thoại bao gồm 10 chữ số';
    if (phoneNumber.isEmpty) {
      emit(state.copyWithNotAddress(phoneNumberAnnouncement: ''));
      return;
    }

    if (phoneNumber.isNotEmpty &&
        Validate().isInvalidPhoneNumber(phoneNumber)) {
      emit(state.copyWithNotAddress(
          phoneNumberAnnouncement: phoneNumberValidatedAnnouncement));
      return;
    }
    emit(state.copyWithNotAddress(phoneNumberAnnouncement: ''));
  }

  void checkAll() {
    _checkNameTextField();
    _checkPhoneNumber();

    final isAllValidated = _isValidatedTexField() & _isValidatedAddress();

    emit(state.copyWithNotAddress(isAllValidated: isAllValidated));
  }

  bool _isValidatedAddress() {
    return state.district != null &&
        state.ward != null &&
        state.province != null &&
        state.street.isNotEmpty;
  }

  bool _isValidatedTexField() {
    if (state.name.isEmpty || state.phoneNumber.isEmpty) {
      return false;
    }
    if (Validate().isInvalidName(state.name) ||
        Validate().isInvalidPhoneNumber(state.phoneNumber)) {
      return false;
    }
    return true;
  }

  setProvince(Province province) {
    emit(state.copyWith(
      province: province,
      districts: province.districts,
      district: null,
      wards: null,
      ward: null,
    ));
  }

  setDistrict(District district) {
    emit(state.copyWith(
      district: district,
      districts: state.districts,
      province: state.province,
      wards: district.wards,
      ward: null,
    ));
  }

  setWard(Ward ward) {
    emit(state.copyWith(
      province: state.province,
      districts: state.districts,
      district: state.district,
      wards: state.wards,
      ward: ward,
    ));
  }
}
