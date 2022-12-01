import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
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

part 'detail_address_state.dart';

enum DetailAddressEnum {
  address,
  isAllValidated,
  provinces,
  province,
  district,
  ward,
  isLoading,
  isDefault,
  street,
  phoneNumber,
  name
}

class DetailAddressCubit extends Cubit<DetailAddressState>
    implements ParentCubit<DetailAddressEnum> {
  DetailAddressCubit({required Address address})
      : super(DetailAddressInitial(
          address: address,
          isAllValidated: true,
          provinces: const [],
          province: null,
          district: null,
          street: address.addressCode!.street!,
          ward: null,
          districts: null,
          wards: null,
          isLoading: false,
          isDefault: address.isDefault,
          name: address.name,
          phoneNumber: address.phoneNumber,
        ));

  final DeliveryRepository _deliveryRepository =
      getIt<DeliveryRepositoryImpl>();
  final LocationRepository _locationRepository =
      getIt<LocationRepositoryImpl>();

  _getLocation() async {
    addNewEvent(DetailAddressEnum.isLoading, true);
    final result = await _locationRepository.getProvinces();

    if (result.isSuccess) {
      final provinces = result.data;
      addNewEvent(DetailAddressEnum.provinces, provinces);

      final province = provinces!.firstWhere(
          (element) => element.code == state.address.addressCode!.provinceId);
      addNewEvent(DetailAddressEnum.province, province);

      final district = province.districts.firstWhere(
          (element) => element.code == state.address.addressCode!.district);
      addNewEvent(DetailAddressEnum.district, district);
      final ward = district.wards.firstWhere(
          (element) => element.code == state.address.addressCode!.wardId);
      addNewEvent(DetailAddressEnum.ward, ward);
    }

    addNewEvent(DetailAddressEnum.isLoading, false);
  }

  initCubit() {
    _setFields();
    _getLocation();
  }

  _setFields() {}

  updateAddress() async {
    addNewEvent(DetailAddressEnum.isLoading, true);
    if (state.isDefault) {
      _deliveryRepository.setDefaultAddress(addressId: state.address.id!);
    }
    final newAddress = Address(
        id: state.address.id,
        addressCode: AddressCode(
            district: state.district!.code,
            provinceId: state.province!.code,
            street: state.street,
            wardId: state.ward!.code),
        name: state.name,
        phoneNumber: state.phoneNumber,
        address:
            '${state.street}, ${state.ward!.name}, ${state.district!.name}, ${state.province!.name}');
    await _deliveryRepository.updateAddress(
      address: newAddress,
    );

    addNewEvent(DetailAddressEnum.isLoading, false);
  }

  void checkAll(String name, String phoneNumber, String detailAddress) {
    addNewEvent(DetailAddressEnum.isAllValidated,
        checkValidatedTexField(name, phoneNumber, detailAddress));
  }

  bool checkValidatedTexField(
      String name, String phoneNumber, String detailAddress) {
    if (name.isEmpty || phoneNumber.isEmpty || detailAddress.isEmpty) {
      return false;
    }
    if (Validate().isInvalidName(name) ||
        Validate().isInvalidPhoneNumber(phoneNumber)) {
      return false;
    }
    return true;
  }

  @override
  void addNewEvent(DetailAddressEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case DetailAddressEnum.isAllValidated:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          isAllValidated: value,
          province: state.province,
          district: state.district,
          ward: state.ward,
          districts: state.districts,
          wards: state.wards,
        ));
        break;
      case DetailAddressEnum.isDefault:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          isDefault: value,
          province: state.province,
          district: state.district,
          ward: state.ward,
          districts: state.districts,
          wards: state.wards,
        ));
        break;
      case DetailAddressEnum.isLoading:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          isLoading: value,
          province: state.province,
          district: state.district,
          ward: state.ward,
          districts: state.districts,
          wards: state.wards,
        ));
        break;
      case DetailAddressEnum.provinces:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          provinces: value,
          districts: null,
          wards: null,
          province: null,
          district: null,
          ward: null,
        ));

        break;
      case DetailAddressEnum.province:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          province: value,
          districts: (value as Province).districts,
          wards: null,
          district: null,
          ward: null,
        ));
        break;
      case DetailAddressEnum.district:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          districts: state.districts,
          wards: (value as District).wards,
          province: state.province,
          district: value,
          ward: null,
        ));

        break;
      case DetailAddressEnum.ward:
        emit(NewDetailAddressState.fromOldSettingState(
          state,
          districts: state.districts,
          wards: state.wards,
          province: state.province,
          district: state.district,
          ward: value,
        ));
        break;

      case DetailAddressEnum.street:
        emit(NewDetailAddressState.fromOldSettingState(state,
            districts: state.districts,
            wards: state.wards,
            province: state.province,
            district: state.district,
            ward: state.ward,
            street: value));
        break;
      case DetailAddressEnum.phoneNumber:
        emit(NewDetailAddressState.fromOldSettingState(state,
            districts: state.districts,
            wards: state.wards,
            province: state.province,
            district: state.district,
            ward: state.ward,
            phoneNumber: value));
        break;
      case DetailAddressEnum.name:
        emit(NewDetailAddressState.fromOldSettingState(state,
            districts: state.districts,
            wards: state.wards,
            province: state.province,
            district: state.district,
            ward: state.ward,
            name: value));
        break;
      default:
    }
  }
}
