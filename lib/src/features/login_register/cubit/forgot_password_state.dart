part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    required this.time,
    required this.announcement,
    required this.otp,
    required this.isLoading,
    required this.userId,
    required this.token,
    required this.emailUser,
    required this.newPassword,
    required this.confirmPassword,
    required this.newPasswordAnnouncement,
    required this.confirmPasswordAnnouncement,
    required this.totalAnnouncement,
  });

  final String announcement;
  final String time;
  final String userId;
  final String token;
  final String otp;
  final String emailUser;
  final String newPassword;
  final String confirmPassword;
  final String newPasswordAnnouncement;
  final String confirmPasswordAnnouncement;
  final String totalAnnouncement;
  final bool isLoading;

  @override
  List<Object> get props => [
        announcement,
        userId,
        time,
        otp,
        isLoading,
        token,
        emailUser,
        confirmPassword,
        newPassword,
        newPasswordAnnouncement,
        confirmPasswordAnnouncement,
        totalAnnouncement,
      ];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial({
    required super.announcement,
    required super.time,
    required super.isLoading,
    required super.otp,
    required super.userId,
    required super.token,
    required super.emailUser,
    required super.newPassword,
    required super.confirmPassword,
    required super.newPasswordAnnouncement,
    required super.confirmPasswordAnnouncement,
    required super.totalAnnouncement,
  });
}

class NewForgotPasswordState extends ForgotPasswordState {
  NewForgotPasswordState.fromOldSettingState(
    ForgotPasswordState oldState, {
    String? announcement,
    String? time,
    String? otp,
    String? userId,
    String? emailUser,
    String? token,
    String? newPassword,
    String? confirmPassword,
    String? newPasswordAnnouncement,
    String? confirmPasswordAnnouncement,
    String? totalAnnouncement,
    bool? isLoading,
  }) : super(
          announcement: announcement ?? oldState.announcement,
          emailUser: emailUser ?? oldState.emailUser,
          token: token ?? oldState.token,
          userId: userId ?? oldState.userId,
          time: time ?? oldState.time,
          otp: otp ?? oldState.otp,
          isLoading: isLoading ?? oldState.isLoading,
          newPassword: newPassword ?? oldState.newPassword,
          confirmPassword: confirmPassword ?? oldState.confirmPassword,
          newPasswordAnnouncement:
              newPasswordAnnouncement ?? oldState.newPasswordAnnouncement,
          confirmPasswordAnnouncement: confirmPasswordAnnouncement ??
              oldState.confirmPasswordAnnouncement,
          totalAnnouncement: totalAnnouncement ?? oldState.totalAnnouncement,
        );
}
