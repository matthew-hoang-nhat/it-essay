// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
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

  ForgotPasswordState copyWith({
    String? announcement,
    String? time,
    String? userId,
    String? token,
    String? otp,
    String? emailUser,
    String? newPassword,
    String? confirmPassword,
    String? newPasswordAnnouncement,
    String? confirmPasswordAnnouncement,
    String? totalAnnouncement,
    bool? isLoading,
  }) {
    return ForgotPasswordState(
      announcement: announcement ?? this.announcement,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      otp: otp ?? this.otp,
      emailUser: emailUser ?? this.emailUser,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      newPasswordAnnouncement:
          newPasswordAnnouncement ?? this.newPasswordAnnouncement,
      confirmPasswordAnnouncement:
          confirmPasswordAnnouncement ?? this.confirmPasswordAnnouncement,
      totalAnnouncement: totalAnnouncement ?? this.totalAnnouncement,
      isLoading: isLoading ?? this.isLoading,
    );
  }
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
