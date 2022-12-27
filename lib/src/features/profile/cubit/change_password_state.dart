part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    required this.oldPasswordAnnouncement,
    required this.newPasswordAnnouncement,
    required this.confirmPasswordAnnouncement,
    required this.totalAnnouncement,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.isLoading,
    required this.isAllValidated,
  });

  final String oldPasswordAnnouncement;
  final String newPasswordAnnouncement;
  final String confirmPasswordAnnouncement;
  final String totalAnnouncement;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final bool isAllValidated;

  @override
  List<Object> get props => [
        oldPasswordAnnouncement,
        newPasswordAnnouncement,
        confirmPasswordAnnouncement,
        totalAnnouncement,
        oldPassword,
        newPassword,
        confirmPassword,
        isLoading,
        isAllValidated,
      ];
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial({
    required super.oldPasswordAnnouncement,
    required super.newPasswordAnnouncement,
    required super.confirmPasswordAnnouncement,
    required super.totalAnnouncement,
    required super.oldPassword,
    required super.newPassword,
    required super.confirmPassword,
    required super.isLoading,
    required super.isAllValidated,
  });
}

class NewChangePasswordState extends ChangePasswordState {
  NewChangePasswordState.fromOldSettingState(
    ChangePasswordState oldState, {
    String? oldPasswordAnnouncement,
    String? newPasswordAnnouncement,
    String? confirmPasswordAnnouncement,
    String? totalAnnouncement,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    bool? isAllValidated,
  }) : super(
          oldPasswordAnnouncement:
              oldPasswordAnnouncement ?? oldState.oldPasswordAnnouncement,
          newPasswordAnnouncement:
              newPasswordAnnouncement ?? oldState.newPasswordAnnouncement,
          confirmPasswordAnnouncement: confirmPasswordAnnouncement ??
              oldState.confirmPasswordAnnouncement,
          totalAnnouncement: totalAnnouncement ?? oldState.totalAnnouncement,
          oldPassword: oldPassword ?? oldState.oldPassword,
          newPassword: newPassword ?? oldState.newPassword,
          confirmPassword: confirmPassword ?? oldState.confirmPassword,
          isLoading: isLoading ?? oldState.isLoading,
          isAllValidated: isAllValidated ?? oldState.isAllValidated,
        );
}
