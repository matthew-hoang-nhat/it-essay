import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/features/login_register/cubit/forgot_password_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      body: Stack(
        children: [
          SafeArea(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.newPasswordAnnouncement !=
                      current.newPasswordAnnouncement,
                  builder: (context, state) {
                    return MeTextFieldV2(
                      text: 'Mật khẩu mới',
                      isPassword: true,
                      textEditingController: newPassword,
                      announcement: state.newPasswordAnnouncement,
                      onChanged: () {
                        context.read<ForgotPasswordCubit>()
                          ..addNewEvent(ForgotPasswordStateEnum.newPassword,
                              newPassword.text)
                          ..checkNewPasswordAndConfirmPassword();
                      },
                    );
                  },
                ),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.confirmPasswordAnnouncement !=
                      current.confirmPasswordAnnouncement,
                  builder: (context, state) {
                    return MeTextFieldV2(
                      text: 'Nhập lại mật khẩu mới',
                      isPassword: true,
                      textEditingController: confirmPassword,
                      announcement: state.confirmPasswordAnnouncement,
                      onChanged: () {
                        context.read<ForgotPasswordCubit>()
                          ..addNewEvent(ForgotPasswordStateEnum.confirmPassword,
                              confirmPassword.text)
                          ..checkNewPasswordAndConfirmPassword();
                      },
                    );
                  },
                ),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          context
                              .read<ForgotPasswordCubit>()
                              .changePasswordOnClick(context);
                        },
                        child: const Text('Đổi mật khẩu'));
                  },
                ),
              ],
            ),
          )),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) return const LoadingWidget();
              return Container();
            },
          )
        ],
      ),
    );
  }
}
