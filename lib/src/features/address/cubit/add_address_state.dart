// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_address_cubit.dart';

class AddAddressState extends Equatable {
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
    required this.nameAnnouncement,
    required this.phoneNumberAnnouncement,
    required this.streetAnnouncement,
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
  final String nameAnnouncement;
  final String phoneNumberAnnouncement;
  final String streetAnnouncement;
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
        nameAnnouncement,
        phoneNumberAnnouncement,
        streetAnnouncement
      ];

  AddAddressState copyWithNotAddress(
      {bool? isAllValidated,
      bool? isLoading,
      String? name,
      String? nameAnnouncement,
      String? phoneNumber,
      String? phoneNumberAnnouncement,
      String? street,
      String? streetAnnouncement}) {
    return copyWith(
        provinces: provinces,
        districts: districts,
        wards: wards,
        province: province,
        district: district,
        ward: ward,
        isAllValidated: isAllValidated,
        isLoading: isLoading,
        name: name,
        phoneNumber: phoneNumber,
        phoneNumberAnnouncement: phoneNumberAnnouncement,
        street: street,
        nameAnnouncement: nameAnnouncement,
        streetAnnouncement: streetAnnouncement);
  }

  AddAddressState copyWith({
    bool? isAllValidated,
    bool? isLoading,
    List<Province>? provinces,
    required List<District>? districts,
    required List<Ward>? wards,
    required Province? province,
    required District? district,
    required Ward? ward,
    String? name,
    String? nameAnnouncement,
    String? phoneNumber,
    String? phoneNumberAnnouncement,
    String? street,
    String? streetAnnouncement,
  }) {
    return AddAddressState(
      districts: districts,
      wards: wards,
      province: province,
      district: district,
      ward: ward,
      isAllValidated: isAllValidated ?? this.isAllValidated,
      isLoading: isLoading ?? this.isLoading,
      provinces: provinces ?? this.provinces,
      name: name ?? this.name,
      nameAnnouncement: nameAnnouncement ?? this.nameAnnouncement,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberAnnouncement:
          phoneNumberAnnouncement ?? this.phoneNumberAnnouncement,
      street: street ?? this.street,
      streetAnnouncement: streetAnnouncement ?? this.streetAnnouncement,
    );
  }
}

class AddAddressInitial extends AddAddressState {
  const AddAddressInitial({
    required super.phoneNumber,
    required super.streetAnnouncement,
    required super.name,
    required super.isAllValidated,
    required super.provinces,
    required super.province,
    required super.district,
    required super.ward,
    required super.nameAnnouncement,
    required super.phoneNumberAnnouncement,
    required super.isLoading,
    required super.street,
    required super.districts,
    required super.wards,
  });
}
