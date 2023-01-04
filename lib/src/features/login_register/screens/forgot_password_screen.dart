import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/login_register/cubit/forgot_password_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ForgotPasswordCubit>().refreshCubit();
    return Scaffold(
      appBar: AppBar(title: const Text('Quên mật khẩu')),
      body: Stack(
        children: [
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.announcement != current.announcement,
                  builder: (context, state) {
                    return MeTextFieldV2(
                      text: 'Email',
                      textEditingController:
                          context.read<ForgotPasswordCubit>().emailController,
                      announcement: state.announcement,
                      onChanged: (value) {
                        final email = value;
                        context.read<ForgotPasswordCubit>()
                          ..setEmailUser(email)
                          ..checkValidatedEmail();
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.totalAnnouncement != current.totalAnnouncement,
                  builder: (context, state) {
                    return Text(
                      state.totalAnnouncement,
                      style: GoogleFonts.nunito(color: AppColors.redColor),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<ForgotPasswordCubit>()
                          .sendMailOnClick(context);
                    },
                    child: const Text('Gửi mã OTP'))
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
