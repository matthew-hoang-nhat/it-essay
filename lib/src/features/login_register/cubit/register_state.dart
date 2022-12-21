// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    // required this.emailController,
    // required this.passwordController,
    required this.userId,
    required this.emailUser,
    required this.otpAnnouncement,
    required this.registerAnnouncement,
    required this.time,
    required this.isClickedLogin,
    required this.gender,
    required this.isLoading,
    required this.isCheckBox,
    // required this.meLocalKey
  });
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final String? registerAnnouncement;
  final String? otpAnnouncement;
  final String? userId;
  final String? emailUser;
  final String? time;
  final String gender;
  final bool isClickedLogin;
  final bool isLoading;
  final bool isCheckBox;
  // final Map<String, String> meLocalKey;

  @override
  List<Object?> get props => [
        // emailController,
        // passwordController,
        otpAnnouncement,
        registerAnnouncement,
        isClickedLogin,
        gender,
        emailUser,
        isLoading,
        time,
        isCheckBox
        // meLocalKey
      ];

  RegisterState copyWith({
    String? otpAnnouncement,
    String? registerAnnouncement,
    String? userId,
    String? emailUser,
    String? gender,
    String? time,
    bool? isClickedLogin,
    bool? isLoading,
    bool? isCheckBox,
  }) {
    return RegisterState(
      registerAnnouncement: registerAnnouncement ?? this.registerAnnouncement,
      otpAnnouncement: otpAnnouncement ?? this.otpAnnouncement,
      userId: userId ?? this.userId,
      emailUser: emailUser ?? this.emailUser,
      isClickedLogin: isClickedLogin ?? this.isClickedLogin,
      isLoading: isLoading ?? this.isLoading,
      isCheckBox: isCheckBox ?? this.isCheckBox,
      gender: gender ?? this.gender,
      time: time ?? this.time,
    );
  }
}

class RegisterInitial extends RegisterState {
  const RegisterInitial(
      {
      //   required super.emailController,
      // required super.passwordController,
      required super.otpAnnouncement,
      required super.registerAnnouncement,
      required super.userId,
      required super.emailUser,
      required super.isClickedLogin,
      required super.isLoading,
      required super.isCheckBox,
      required super.gender,
      required super.time
      // required super.meLocalKey
      });
}
