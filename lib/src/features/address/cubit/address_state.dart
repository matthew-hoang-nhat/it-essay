part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState({
    required this.addresses,
    required this.isEmpty,
  });

  final List<Address> addresses;
  final bool isEmpty;

  @override
  List<Object> get props => [addresses, isEmpty];
}

class AddressInitial extends AddressState {
  const AddressInitial({
    required super.addresses,
    required super.isEmpty,
  });
}

class NewAddressState extends AddressState {
  NewAddressState.fromOldSettingState(
    AddressState oldState, {
    List<Address>? addresses,
    bool? isEmpty,
  }) : super(
          addresses: addresses ?? oldState.addresses,
          isEmpty: isEmpty ?? oldState.isEmpty,
        );
}
