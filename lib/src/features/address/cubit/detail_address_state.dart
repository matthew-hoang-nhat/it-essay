// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_address_cubit.dart';

class DetailAddressState extends Equatable {
  const DetailAddressState({
    required this.address,
    required this.name,
    required this.phoneNumber,
    required this.provinces,
    required this.districts,
    required this.wards,
    required this.isAllValidated,
    required this.isDefault,
    required this.isLoading,
    required this.province,
    required this.street,
    required this.district,
    required this.ward,
    required this.phoneNumberAnnouncement,
    required this.nameAnnouncement,
    required this.streetAnnouncement,
  });

  final Address address;
  final bool isAllValidated;
  final bool isLoading;
  final bool isDefault;

  final List<Province> provinces;
  final List<District>? districts;
  final List<Ward>? wards;

  final Province? province;
  final District? district;
  final Ward? ward;

  final String name;
  final String phoneNumber;
  final String street;
  final String phoneNumberAnnouncement;
  final String nameAnnouncement;
  final String streetAnnouncement;

  @override
  List<Object?> get props => [
        isAllValidated,
        provinces,
        districts,
        wards,
        province,
        district,
        ward,
        isDefault,
        isLoading,
        name,
        phoneNumber,
        street,
        phoneNumberAnnouncement,
        nameAnnouncement,
        streetAnnouncement,
      ];

  DetailAddressState copyWithNotAddress(
      {bool? isAllValidated,
      bool? isLoading,
      String? name,
      String? nameAnnouncement,
      String? phoneNumber,
      String? phoneNumberAnnouncement,
      String? street,
      String? streetAnnouncement,
      bool? isDefault}) {
    return copyWith(
        isDefault: isDefault,
        address: address,
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

  DetailAddressState copyWith({
    Address? address,
    bool? isDefault,
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
    return DetailAddressState(
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
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

class DetailAddressInitial extends DetailAddressState {
  const DetailAddressInitial({
    required super.address,
    required super.phoneNumber,
    required super.name,
    required super.isAllValidated,
    required super.provinces,
    required super.isDefault,
    required super.province,
    required super.district,
    required super.ward,
    required super.isLoading,
    required super.street,
    required super.districts,
    required super.wards,
    required super.nameAnnouncement,
    required super.phoneNumberAnnouncement,
    required super.streetAnnouncement,
  });
}
