part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState({
    required this.profileUser,
  });

  final FUserLocalDao profileUser;

  @override
  List<Object?> get props => [
        profileUser,
      ];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({
    required super.profileUser,
  });
}

class NewProfileState extends ProfileState {
  NewProfileState.fromOldSettingState(
    ProfileState oldState, {
    FUserLocalDao? profileUser,
  }) : super(
          profileUser: profileUser ?? oldState.profileUser,
        );
}
