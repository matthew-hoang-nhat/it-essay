import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/profile/cubit/change_password_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Đổi mật khẩu')),
        body: Stack(
          children: [
            SafeArea(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    buildWhen: (previous, current) =>
                        previous.oldPasswordAnnouncement !=
                        current.oldPasswordAnnouncement,
                    builder: (context, state) {
                      return MeTextFieldV2(
                        text: 'Mật khẩu cũ',
                        isPassword: true,
                        textEditingController: oldPassword,
                        announcement: state.oldPasswordAnnouncement,
                        onChanged: () {
                          context.read<ChangePasswordCubit>()
                            ..addNewEvent(ChangePasswordStateEnum.oldPassword,
                                oldPassword.text)
                            ..checkAllTextFields();
                        },
                      );
                    },
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                          context.read<ChangePasswordCubit>()
                            ..addNewEvent(ChangePasswordStateEnum.newPassword,
                                newPassword.text)
                            ..checkAllTextFields();
                        },
                      );
                    },
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                          context.read<ChangePasswordCubit>()
                            ..addNewEvent(
                                ChangePasswordStateEnum.confirmPassword,
                                confirmPassword.text)
                            ..checkAllTextFields();
                        },
                      );
                    },
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    buildWhen: (previous, current) =>
                        previous.isAllValidated != current.isAllValidated,
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: state.isAllValidated
                              ? () {
                                  context
                                      .read<ChangePasswordCubit>()
                                      .changePasswordOnClick(context);
                                }
                              : null,
                          child: const Text('Đổi mật khẩu'));
                    },
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    buildWhen: (previous, current) =>
                        previous.totalAnnouncement != current.totalAnnouncement,
                    builder: (context, state) {
                      return Text(
                        state.totalAnnouncement,
                        style: GoogleFonts.nunito(color: AppColors.redColor),
                      );
                    },
                  )
                ],
              ),
            )),
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading) return const LoadingWidget();
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
