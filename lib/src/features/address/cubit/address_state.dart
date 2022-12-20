// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_cubit.dart';

class AddressState extends Equatable {
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

  AddressState copyWith({
    List<Address>? addresses,
    bool? isEmpty,
    bool? isLoading,
    String? addressId,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      isEmpty: isEmpty ?? this.isEmpty,
      isLoading: isLoading ?? this.isLoading,
      addressId: addressId ?? this.addressId,
    );
  }
}

class AddressInitial extends AddressState {
  const AddressInitial({
    required super.addresses,
    required super.isEmpty,
    required super.addressId,
    required super.isLoading,
  });
}
