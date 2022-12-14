part of 'add_address_cubit.dart';

abstract class AddAddressState extends Equatable {
  const AddAddressState({
    required this.name,
    required this.phoneNumber,
    required this.provinces,
    required this.districts,
    required this.wards,
    required this.isAllValidated,
    required this.isLoading,
    required this.province,
    required this.street,
    required this.district,
    required this.ward,
  });

  final bool isAllValidated;
  final bool isLoading;

  final List<Province> provinces;
  final List<District>? districts;
  final List<Ward>? wards;

  final Province? province;
  final District? district;
  final Ward? ward;

  final String name;
  final String phoneNumber;
  final String street;

  @override
  List<Object?> get props => [
        isAllValidated,
        provinces,
        province,
        district,
        ward,
        isLoading,
        street,
        phoneNumber,
        name,
      ];
}

class AddAddressInitial extends AddAddressState {
  const AddAddressInitial({
    required super.phoneNumber,
    required super.name,
    required super.isAllValidated,
    required super.provinces,
    required super.province,
    required super.district,
    required super.ward,
    required super.isLoading,
    required super.street,
    required super.districts,
    required super.wards,
  });
}

class NewAddAddressState extends AddAddressState {
  NewAddAddressState.fromOldSettingState(
    AddAddressState oldState, {
    Address? address,
    bool? isAllValidated,
    bool? isLoading,
    String? street,
    String? phoneNumber,
    String? name,
    List<Province>? provinces,
    required List<District>? districts,
    required List<Ward>? wards,
    required Province? province,
    required District? district,
    required Ward? ward,
  }) : super(
          isAllValidated: isAllValidated ?? oldState.isAllValidated,
          isLoading: isLoading ?? oldState.isLoading,
          provinces: provinces ?? oldState.provinces,
          street: street ?? oldState.street,
          phoneNumber: phoneNumber ?? oldState.phoneNumber,
          name: name ?? oldState.name,
          districts: districts,
          wards: wards,
          province: province,
          district: district,
          ward: ward,
        );
}
