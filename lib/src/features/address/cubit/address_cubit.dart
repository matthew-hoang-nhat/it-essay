import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/repository/delivery_repository.dart';
import 'package:it_project/src/utils/repository/delivery_repository_impl.dart';

part 'address_state.dart';

enum AddressEnum { addresses, isEmpty, addressId, isLoading }

class AddressCubit extends Cubit<AddressState>
    implements ParentCubit<AddressEnum> {
  AddressCubit()
      : super(const AddressInitial(
            addresses: [], isEmpty: false, addressId: null, isLoading: true));
  final DeliveryRepository _deliveryRepository =
      getIt<DeliveryRepositoryImpl>();

  Future<bool> addAddress(Address address) async {
    final result = await _deliveryRepository.addAddress(address: address);
    return result.isSuccess;
  }

  Future<void> initCubit() async {
    await getAddresses();
  }

  getAddresses() async {
    addNewEvent(AddressEnum.isLoading, true);

    final addressesResponse = await _deliveryRepository.getAddresses();
    if (addressesResponse.isSuccess) {
      addNewEvent(AddressEnum.addresses, addressesResponse.data);
      _checkEmptyAddresses();
    }
    addNewEvent(AddressEnum.isLoading, false);
  }

  _checkEmptyAddresses() {
    if (state.addresses.isEmpty) addNewEvent(AddressEnum.isEmpty, true);
  }

  deleteAddress(String addressId) async {
    final newAddresses = List<Address>.from(state.addresses);
    newAddresses.removeWhere(
      (element) => element.id == addressId,
    );
    addNewEvent(AddressEnum.addresses, newAddresses);
    _checkEmptyAddresses();
    await _deliveryRepository.deleteAddress(addressId: addressId);
  }

  @override
  void addNewEvent(AddressEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case AddressEnum.addresses:
        emit(NewAddressState.fromOldSettingState(state, addresses: value));

        break;
      case AddressEnum.addressId:
        emit(NewAddressState.fromOldSettingState(state, addressId: value));
        break;
      case AddressEnum.isEmpty:
        emit(NewAddressState.fromOldSettingState(state, isEmpty: value));
        break;
      case AddressEnum.isLoading:
        emit(NewAddressState.fromOldSettingState(state, isLoading: value));
        break;
      default:
    }
  }
}
