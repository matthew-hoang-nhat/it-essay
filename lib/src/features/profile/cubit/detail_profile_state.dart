// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_profile_cubit.dart';

class DetailProfileState extends Equatable {
  const DetailProfileState(
      {required this.isLoading,
      required this.firstNameAnnouncement,
      required this.lastNameAnnouncement,
      required this.phoneNumberAnnouncement,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.newAvatar,
      required this.phoneNumber,
      required this.dateTime,
      required this.gender,
      required this.isAllValidated});

  final bool isLoading;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String firstNameAnnouncement;
  final String lastNameAnnouncement;
  final String phoneNumberAnnouncement;
  final String? dateTime;
  final String gender;
  final XFile? newAvatar;
  final String? avatar;
  final bool isAllValidated;

  @override
  List<Object?> get props => [
        isLoading,
        newAvatar,
        avatar,
        gender,
        dateTime,
        firstName,
        lastName,
        phoneNumber,
        isAllValidated,
        firstNameAnnouncement,
        lastNameAnnouncement,
        phoneNumberAnnouncement
      ];

  DetailProfileState copyWith({
    bool? isLoading,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? firstNameAnnouncement,
    String? lastNameAnnouncement,
    String? phoneNumberAnnouncement,
    String? dateTime,
    String? gender,
    XFile? newAvatar,
    String? avatar,
    bool? isAllValidated,
  }) {
    return DetailProfileState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstNameAnnouncement:
          firstNameAnnouncement ?? this.firstNameAnnouncement,
      lastNameAnnouncement: lastNameAnnouncement ?? this.lastNameAnnouncement,
      phoneNumberAnnouncement:
          phoneNumberAnnouncement ?? this.phoneNumberAnnouncement,
      dateTime: dateTime ?? this.dateTime,
      gender: gender ?? this.gender,
      newAvatar: newAvatar ?? this.newAvatar,
      avatar: avatar ?? this.avatar,
      isAllValidated: isAllValidated ?? this.isAllValidated,
    );
  }
}

class DetailProfileInitial extends DetailProfileState {
  const DetailProfileInitial({
    required super.isLoading,
    required super.isAllValidated,
    required super.avatar,
    required super.dateTime,
    required super.firstNameAnnouncement,
    required super.lastNameAnnouncement,
    required super.phoneNumberAnnouncement,
    required super.email,
    required super.gender,
    required super.firstName,
    required super.lastName,
    required super.newAvatar,
    required super.phoneNumber,
  });
}
