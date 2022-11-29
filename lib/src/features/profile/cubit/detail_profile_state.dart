part of 'detail_profile_cubit.dart';

abstract class DetailProfileState extends Equatable {
  const DetailProfileState(
      {required this.isLoading,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.newAvatar,
      required this.phoneNumber,
      required this.dateTime,
      required this.gender});

  final bool isLoading;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? dateTime;
  final String gender;
  final XFile? newAvatar;
  final String? avatar;

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
      ];
}

class DetailProfileInitial extends DetailProfileState {
  const DetailProfileInitial({
    required super.isLoading,
    required super.avatar,
    required super.dateTime,
    required super.email,
    required super.gender,
    required super.firstName,
    required super.lastName,
    required super.newAvatar,
    required super.phoneNumber,
  });
}

class NewDetailProfileState extends DetailProfileState {
  NewDetailProfileState.fromOldSettingState(
    DetailProfileState oldState, {
    bool? isLoading,
    String? dateTime,
    String? email,
    String? gender,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? avatar,
    XFile? newAvatar,
  }) : super(
            isLoading: isLoading ?? oldState.isLoading,
            dateTime: dateTime ?? oldState.dateTime,
            email: email ?? oldState.email,
            gender: gender ?? oldState.gender,
            firstName: firstName ?? oldState.firstName,
            lastName: lastName ?? oldState.lastName,
            avatar: avatar ?? oldState.avatar,
            newAvatar: newAvatar ?? oldState.newAvatar,
            phoneNumber: phoneNumber ?? oldState.phoneNumber);
}
