part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState({
    // required this.emailController,
    // required this.passwordController,
    required this.announcement,
    required this.isClickedLogin,
    required this.isLoading,
    required this.isCheckBox,
    // required this.meLocalKey
  });
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final String? announcement;
  final bool isClickedLogin;
  final bool isLoading;
  final bool isCheckBox;
  // final Map<String, String> meLocalKey;

  @override
  List<Object?> get props => [
        // emailController,
        // passwordController,
        announcement,
        isClickedLogin,
        isLoading,
        isCheckBox
        // meLocalKey
      ];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial(
      {
      //   required super.emailController,
      // required super.passwordController,
      required super.announcement,
      required super.isClickedLogin,
      required super.isLoading,
      required super.isCheckBox
      // required super.meLocalKey
      });
}

class NewRegisterState extends RegisterState {
  NewRegisterState.fromOldSettingState(
    RegisterState oldState, {
    // TextEditingController? emailController,
    // TextEditingController? passwordController,
    String? announcement,
    bool? isClickedLogin,
    bool? isLoading,
    bool? isCheckBox,
    // Map<String, String>? meLocalKey,
  }) : super(
          // emailController: emailController ?? oldState.emailController,
          // passwordController:
          // passwordController ?? oldState.passwordController,
          announcement: announcement,
          isClickedLogin: isClickedLogin ?? oldState.isClickedLogin,
          isLoading: isLoading ?? oldState.isLoading,
          isCheckBox: isCheckBox ?? oldState.isCheckBox,
          // meLocalKey: meLocalKey ?? oldState.meLocalKey
        );
}
