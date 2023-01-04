import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/repository/delivery_repository.dart';
import 'package:it_project/src/utils/repository/delivery_repository_impl.dart';

part 'address_state.dart';

enum AddressEnum { addresses, isEmpty, addressId, isLoading }

class AddressCubit extends Cubit<AddressState> {
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

  setAddressId(value) {
    emit(state.copyWith(addressId: value));
  }

  getAddresses() async {
    emit(state.copyWith(isLoading: true));

    final addressesResponse = await _deliveryRepository.getAddresses();
    if (addressesResponse.isSuccess) {
      emit(state.copyWith(addresses: addressesResponse.data));
      _checkEmptyAddresses();
    }
    emit(state.copyWith(isLoading: false));
  }

  _checkEmptyAddresses() {
    if (state.addresses.isEmpty) {
      emit(state.copyWith(isEmpty: true));
    }
  }

  deleteAddress(String addressId) async {
    final newAddresses = List<Address>.from(state.addresses);
    newAddresses.removeWhere(
      (element) => element.id == addressId,
    );
    emit(state.copyWith(addresses: newAddresses));
    _checkEmptyAddresses();
    await _deliveryRepository.deleteAddress(addressId: addressId);
  }
}
