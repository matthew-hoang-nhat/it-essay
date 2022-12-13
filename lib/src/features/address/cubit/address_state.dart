part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState({
    required this.addresses,
    required this.isEmpty,
    required this.addressId,
    required this.isLoading,
  });

  final List<Address> addresses;
  final bool isEmpty;
  final bool isLoading;
  final String? addressId;

  @override
  List<Object?> get props => [
        addresses,
        isEmpty,
        addressId,
        isLoading,
      ];
}

class AddressInitial extends AddressState {
  const AddressInitial({
    required super.addresses,
    required super.isEmpty,
    required super.addressId,
    required super.isLoading,
  });
}

class NewAddressState extends AddressState {
  NewAddressState.fromOldSettingState(
    AddressState oldState, {
    List<Address>? addresses,
    String? addressId,
    bool? isEmpty,
    bool? isLoading,
  }) : super(
          addresses: addresses ?? oldState.addresses,
          isEmpty: isEmpty ?? oldState.isEmpty,
          addressId: addressId ?? oldState.addressId,
          isLoading: isLoading ?? oldState.isLoading,
        );
}
