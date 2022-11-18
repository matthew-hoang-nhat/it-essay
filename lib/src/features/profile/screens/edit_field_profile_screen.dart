import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/profile/cubit/edit_profile_cubit.dart';
import 'package:it_project/src/features/profile/widgets/me_edit_text_field.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/widgets/load_widget.dart';

enum EditFieldProfileEnum {
  name,
  phoneNumber,
}

class EditFieldProfileScreen extends StatelessWidget {
  const EditFieldProfileScreen({super.key, required this.type, this.content});
  final EditFieldProfileEnum type;
  final String? content;

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController(text: content);
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.whiteGreyColor,
            appBar: AppBar(
              foregroundColor: AppColors.brownColor,
              title: Text(
                getTitle(),
                style: GoogleFonts.nunito(color: AppColors.brownColor),
              ),
              actions: [
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () async {
                        if (announcementErrorInvalid(
                                textEditingController.text) !=
                            null) {
                          return;
                        }
                        switch (type) {
                          case EditFieldProfileEnum.name:
                            await context
                                .read<EditProfileCubit>()
                                .updateProfile(name: textEditingController.text)
                                .then((value) {
                              if (value) {
                                context.read<AppCubit>().fetchFUser();
                                context.pop();
                              }
                            });
                            break;
                          case EditFieldProfileEnum.phoneNumber:
                            await context
                                .read<EditProfileCubit>()
                                .updateProfile(
                                    phone: textEditingController.text)
                                .then((value) {
                              if (value) {
                                context.read<AppCubit>().fetchFUser();
                                context.pop();
                              }
                            });
                            break;
                          default:
                        }
                      },
                      style: ButtonStyle(
                        textStyle: MaterialStateTextStyle.resolveWith(
                            (states) =>
                                GoogleFonts.nunito(color: AppColors.redColor)),
                        foregroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor),
                      ),
                      child: const Text(
                        'Lưu',
                      ),
                    );
                  },
                )
              ],
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 5),
              MeEditTextField(
                textEditingController: textEditingController,
                // typeEdit: type,
                func: (value) {
                  return announcementErrorInvalid(value);
                },
              ),
            ]),
          ),
          BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return state.isLoading == true ? const LoadWidget() : Container();
            },
          )
        ],
      ),
    );
  }

  String? announcementErrorInvalid(value) {
    switch (type) {
      case EditFieldProfileEnum.name:
        if (Validate().isInvalidName(value)) {
          return 'Tên chứa nhiều nhất 30 kí tự';
        }
        break;
      case EditFieldProfileEnum.phoneNumber:
        if (Validate().isInvalidNumber(value)) {
          return 'Yêu cầu có 10 chữ số ';
        }
        break;
      default:
    }
    return null;
  }

  String getTitle() {
    switch (type) {
      case EditFieldProfileEnum.name:
        return 'Sửa tên';

      case EditFieldProfileEnum.phoneNumber:
        return 'Sửa số điện thoại';
    }
  }
}
