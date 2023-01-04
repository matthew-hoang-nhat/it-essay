// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
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

  ChangePasswordState copyWith({
    String? oldPasswordAnnouncement,
    String? newPasswordAnnouncement,
    String? confirmPasswordAnnouncement,
    String? totalAnnouncement,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    bool? isAllValidated,
  }) {
    return ChangePasswordState(
      oldPasswordAnnouncement:
          oldPasswordAnnouncement ?? this.oldPasswordAnnouncement,
      newPasswordAnnouncement:
          newPasswordAnnouncement ?? this.newPasswordAnnouncement,
      confirmPasswordAnnouncement:
          confirmPasswordAnnouncement ?? this.confirmPasswordAnnouncement,
      totalAnnouncement: totalAnnouncement ?? this.totalAnnouncement,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isAllValidated: isAllValidated ?? this.isAllValidated,
    );
  }
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
