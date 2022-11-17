part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState({
    required this.emailController,
    required this.passwordController,
    required this.announcementLogin,
    required this.isClickedLogin,
    required this.isLoading,
    // required this.meLocalKey
  });
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final String announcementLogin;
  final bool isClickedLogin;
  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [
        // emailController,
        // passwordController,
        announcementLogin,
        isClickedLogin,
        isLoading,
        // meLocalKey
      ];
}

class LoginInitial extends LoginState {
  const LoginInitial({
    required super.emailController,
    required super.passwordController,
    required super.announcementLogin,
    required super.isClickedLogin,
    required super.isLoading,
    // required super.meLocalKey
  });
}

class NewLoginState extends LoginState {
  NewLoginState.fromOldSettingState(
    LoginState oldState, {
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? announcementLogin,
    bool? isClickedLogin,
    bool? isLoading,
    // Map<String, String>? meLocalKey,
  }) : super(
          emailController: emailController ?? oldState.emailController,
          passwordController: passwordController ?? oldState.passwordController,
          announcementLogin: announcementLogin ?? oldState.announcementLogin,
          isClickedLogin: isClickedLogin ?? oldState.isClickedLogin,
          isLoading: isLoading ?? oldState.isLoading,
          // meLocalKey: meLocalKey ?? oldState.meLocalKey
        );
}
