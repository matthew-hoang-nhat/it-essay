part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  List<Object> get props => [isLoading];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial({required super.isLoading});
}

class NewEditProfileState extends EditProfileState {
  NewEditProfileState.fromOldSettingState(
    EditProfileState oldState, {
    bool? isLoading,
  }) : super(
          isLoading: isLoading ?? oldState.isLoading,
        );
}
