import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/features/login_register/cubit/forgot_password_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      textEditingController: context
                          .read<ForgotPasswordCubit>()
                          .newPasswordController,
                      announcement: state.newPasswordAnnouncement,
                      onChanged: (value) {
                        final newPassword = value;
                        context.read<ForgotPasswordCubit>()
                          ..setNewPassword(newPassword)
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
                      textEditingController: context
                          .read<ForgotPasswordCubit>()
                          .confirmPasswordController,
                      announcement: state.confirmPasswordAnnouncement,
                      onChanged: (value) {
                        final confirmPassword = value;
                        context.read<ForgotPasswordCubit>()
                          ..setConfirmPassword(confirmPassword)
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
