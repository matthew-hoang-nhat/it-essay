import 'dart:io';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/profile/cubit/detail_profile_cubit.dart';
import 'package:it_project/src/features/profile/widgets/me_drop_down.dart';
import 'package:it_project/src/features/profile/widgets/me_pick_date.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

enum EditFieldProfileEnum {
  phoneNumber,
  gender,
  birthDay,
  firstName,
  lastName,
}

class DetailProfileScreen extends StatelessWidget {
  const DetailProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailProfileCubit>(
      create: (context) => DetailProfileCubit()..initCubit(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sửa hồ sơ',
                // style: GoogleFonts.nunito(color: AppColors.brownColor),
              ),
              actions: [updateProfileButton()],
            ),
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                componentAvatar(),
                componentTextField(context),
              ],
            )),
          ),
          BlocBuilder<DetailProfileCubit, DetailProfileState>(
            builder: (context, state) {
              if (state.isLoading == false) return Container();
              return const LoadingWidget(
                loadingType: LoadingTypeEnum.fast,
              );
            },
          )
        ],
      ),
    );
  }

  Widget updateProfileButton() {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      buildWhen: (previous, current) =>
          previous.isAllValidated != current.isAllValidated,
      builder: (context, state) {
        final isValidated = state.isAllValidated;
        return TextButton(
            style: TextButton.styleFrom(
              foregroundColor:
                  isValidated ? AppColors.whiteColor : AppColors.greyColor,
            ),
            onPressed: isValidated
                ? () async {
                    if (isValidated) {
                      await context
                          .read<DetailProfileCubit>()
                          .updateProfileClick()
                          .then((value) {
                        context.read<AppCubit>().fetchFUser();
                        context.pop();
                      });
                    }
                  }
                : null,
            child: const Text('Lưu thay đổi'));
      },
    );
  }

  Widget componentAvatar() {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      buildWhen: (previous, current) => previous.newAvatar != current.newAvatar,
      builder: (context, state) {
        Widget showAvatar() {
          if (state.newAvatar != null) {
            return Image.file(
              File(state.newAvatar!.path),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            );
          }
          if (state.avatar == null || state.avatar == '') {
            return Container(
              height: 100,
              width: 100,
              color: AppColors.whiteColor,
            );
          }

          return CachedNetworkImage(
            imageUrl: state.avatar!,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              height: 100,
              width: 100,
              color: AppColors.whiteColor,
            ),
          );
        }

        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            AppColors.primaryColor,
                            Colors.black.withOpacity(0)
                          ],
                          stops: const [
                            0.1,
                            0.3,
                            0.75
                          ]).createShader(rect);
                    },
                    blendMode: BlendMode.darken,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    await picker
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        context.read<DetailProfileCubit>().setNewAvatar(value);
                      }
                      return null;
                    });
                  },
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: showAvatar()),
                  ),
                )
              ],
            ),
            Container(
                width: double.infinity,
                color: AppColors.brownColor.withOpacity(0.5),
                alignment: Alignment.center,
                child: Text(
                  'Chạm để thay đổi',
                  style: GoogleFonts.nunito(color: AppColors.whiteColor),
                )),
          ],
        );
      },
    );
  }

  Widget componentTextField(context) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        BlocBuilder<DetailProfileCubit, DetailProfileState>(
          builder: (context, state) {
            return MeTextFieldV2(
                text: 'Email',
                isEnabled: false,
                textEditingController:
                    context.read<DetailProfileCubit>().emailEditingController,
                announcement: null,
                onChanged: (value) => null);
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<DetailProfileCubit, DetailProfileState>(
          buildWhen: (previous, current) =>
              previous.firstNameAnnouncement != current.firstNameAnnouncement,
          builder: (context, state) {
            return MeTextFieldV2(
                text: 'Họ',
                textEditingController: context
                    .read<DetailProfileCubit>()
                    .firstNameEditingController,
                announcement: state.firstNameAnnouncement,
                onChanged: (value) {
                  context.read<DetailProfileCubit>()
                    ..setFirstName(value)
                    ..checkTextFieldValidate(value,
                        type: EditFieldProfileEnum.firstName);
                });
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<DetailProfileCubit, DetailProfileState>(
          buildWhen: (previous, current) =>
              previous.lastNameAnnouncement != current.lastNameAnnouncement,
          builder: (context, state) {
            return MeTextFieldV2(
                text: 'Tên',
                textEditingController: context
                    .read<DetailProfileCubit>()
                    .lastNameEditingController,
                announcement: state.lastNameAnnouncement,
                onChanged: (value) {
                  context.read<DetailProfileCubit>()
                    ..setLastName(value)
                    ..checkTextFieldValidate(value,
                        type: EditFieldProfileEnum.lastName);
                });
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<DetailProfileCubit, DetailProfileState>(
          buildWhen: (previous, current) =>
              previous.phoneNumberAnnouncement !=
              current.phoneNumberAnnouncement,
          builder: (context, state) {
            return MeTextFieldV2(
                text: 'Số điện thoại',
                textEditingController:
                    context.read<DetailProfileCubit>().phoneNumberController,
                announcement: state.phoneNumberAnnouncement,
                onChanged: (value) {
                  context.read<DetailProfileCubit>()
                    ..setPhoneNumber(value)
                    ..checkTextFieldValidate(value,
                        type: EditFieldProfileEnum.phoneNumber);
                });
          },
        ),
        const SizedBox(height: 10),
        Text('Ngày sinh nhật',
            style: GoogleFonts.nunito(
                color: AppColors.greyColor, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        BlocBuilder<DetailProfileCubit, DetailProfileState>(
          buildWhen: (previous, current) =>
              previous.dateTime != current.dateTime,
          builder: (context, state) {
            return MePickDate(
              initDateTime: (state.dateTime == '' || state.dateTime == null)
                  ? DateTime.now()
                  : DateFormat("dd-MM-yyyy").parse(state.dateTime!),
              func: (DateTime? value) {
                final dateTime =
                    value == null ? null : dateFormat.format(value);
                context.read<DetailProfileCubit>().setDateTime(dateTime);
              },
            );
          },
        ),
        const SizedBox(height: 20),
        Text('Giới tính',
            style: GoogleFonts.nunito(
                color: AppColors.greyColor, fontWeight: FontWeight.bold)),
        BlocBuilder<DetailProfileCubit, DetailProfileState>(
          builder: (context, state) {
            return MeDropDown(
                value: state.gender,
                items: const ['male', 'female'],
                func: (value) {
                  final genderValue = value;
                  context.read<DetailProfileCubit>().setGender(genderValue);
                });
          },
        ),
      ]),
    );
  }

  // Widget textField(String title, String? Function(String) funcValidate,
  //     {bool? isEnabled,
  //     Function(String value)? onChanged,
  //     required TextEditingController controller}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(title,
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.greyColor, fontWeight: FontWeight.bold)),
  //                 MeTextFieldV2(textEditingController: controller, announcement: funcValidate(), onChanged: onChanged),
  //         MeTextField(
  //             isEnabled: isEnabled,
  //             functionValidation: funcValidate,
  //             callFuncOnChange: onChanged,
  //             textEditingController: controller),
  //       ],
  //     ),
  //   );
  // }
}
