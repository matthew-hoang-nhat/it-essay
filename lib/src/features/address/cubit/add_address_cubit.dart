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

class AddAddressCubit extends Cubit<AddAddressState>
    implements ParentCubit<AddAddressEnum> {
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
        ));

  final DeliveryRepository _deliveryRepository =
      getIt<DeliveryRepositoryImpl>();
  final LocationRepository _locationRepository =
      getIt<LocationRepositoryImpl>();

  _getLocation() async {
    addNewEvent(AddAddressEnum.isLoading, true);
    final result = await _locationRepository.getProvinces();

    if (result.isSuccess) {
      final provinces = result.data;
      addNewEvent(AddAddressEnum.provinces, provinces);
    }

    addNewEvent(AddAddressEnum.isLoading, false);
  }

  initCubit() {
    _getLocation();
  }

  addNewAddress() async {
    addNewEvent(AddAddressEnum.isLoading, true);

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

    addNewEvent(AddAddressEnum.isLoading, false);
  }

  void checkAll() {
    final isAllValidated = _isValidatedTexField() & _isValidatedAddress();
    addNewEvent(AddAddressEnum.isAllValidated, isAllValidated);
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

  @override
  void addNewEvent(AddAddressEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case AddAddressEnum.isAllValidated:
        emit(NewAddAddressState.fromOldSettingState(
          state,
          isAllValidated: value,
          province: state.province,
          district: state.district,
          ward: state.ward,
          districts: state.districts,
          wards: state.wards,
        ));
        break;
      case AddAddressEnum.isLoading:
        emit(NewAddAddressState.fromOldSettingState(
          state,
          isLoading: value,
          province: state.province,
          district: state.district,
          ward: state.ward,
          districts: state.districts,
          wards: state.wards,
        ));
        break;
      case AddAddressEnum.provinces:
        emit(NewAddAddressState.fromOldSettingState(
          state,
          provinces: value,
          districts: null,
          wards: null,
          province: null,
          district: null,
          ward: null,
        ));

        break;
      case AddAddressEnum.province:
        emit(NewAddAddressState.fromOldSettingState(
          state,
          province: value,
          districts: (value as Province).districts,
          wards: null,
          district: null,
          ward: null,
        ));
        break;
      case AddAddressEnum.district:
        emit(NewAddAddressState.fromOldSettingState(
          state,
          districts: state.districts,
          wards: (value as District).wards,
          province: state.province,
          district: value,
          ward: null,
        ));

        break;
      case AddAddressEnum.ward:
        emit(NewAddAddressState.fromOldSettingState(
          state,
          districts: state.districts,
          wards: state.wards,
          province: state.province,
          district: state.district,
          ward: value,
        ));
        break;

      case AddAddressEnum.street:
        emit(NewAddAddressState.fromOldSettingState(state,
            districts: state.districts,
            wards: state.wards,
            province: state.province,
            district: state.district,
            ward: state.ward,
            street: value));
        break;
      case AddAddressEnum.phoneNumber:
        emit(NewAddAddressState.fromOldSettingState(state,
            districts: state.districts,
            wards: state.wards,
            province: state.province,
            district: state.district,
            ward: state.ward,
            phoneNumber: value));
        break;
      case AddAddressEnum.name:
        emit(NewAddAddressState.fromOldSettingState(state,
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
