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
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field.dart';

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
              title: Text(
                'Sửa hồ sơ',
                style: GoogleFonts.nunito(color: AppColors.brownColor),
              ),
              actions: [updateProfileButton()],
            ),
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                componentAvatar(),
                componentTextField(),
              ],
            )),
          ),
          BlocBuilder<DetailProfileCubit, DetailProfileState>(
            builder: (context, state) {
              if (state.isLoading == false) return Container();
              return const LoadWidget();
            },
          )
        ],
      ),
    );
  }

  Widget updateProfileButton() {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      builder: (context, state) {
        return TextButton(
            onPressed: () async {
              await context
                  .read<DetailProfileCubit>()
                  .updateProfileClick()
                  .then((value) {
                context.read<AppCubit>().fetchFUser();
                context.pop();
              });
            },
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
                        context
                            .read<DetailProfileCubit>()
                            .addNewEvent(DetailProfileEnum.newAvatar, value);
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

  Widget componentTextField() {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        final dateFormat = DateFormat('dd-MM-yyyy');
        final emailEditingController = TextEditingController(text: state.email);
        final firstNameEditingController =
            TextEditingController(text: state.firstName);
        final lastNameEditingController =
            TextEditingController(text: state.lastName);
        final phoneNumberController =
            TextEditingController(text: state.phoneNumber);
        String genderValue = state.gender;

        return Container(
          color: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textField(
              'Email',
              (value) => null,
              controller: emailEditingController,
              isEnabled: false,
            ),
            textField(
                'Họ',
                (value) =>
                    validateFunc(value, type: EditFieldProfileEnum.firstName),
                controller: firstNameEditingController, onChanged: () {
              context.read<DetailProfileCubit>().addNewEvent(
                  DetailProfileEnum.firstName, firstNameEditingController.text);
            }),
            textField(
                'Tên',
                (value) =>
                    validateFunc(value, type: EditFieldProfileEnum.lastName),
                controller: lastNameEditingController, onChanged: () {
              context.read<DetailProfileCubit>().addNewEvent(
                  DetailProfileEnum.lastName, lastNameEditingController.text);
            }),
            textField(
                'Số điện thoại',
                (value) =>
                    validateFunc(value, type: EditFieldProfileEnum.phoneNumber),
                controller: phoneNumberController, onChanged: () {
              context.read<DetailProfileCubit>().addNewEvent(
                  DetailProfileEnum.phoneNumber, phoneNumberController.text);
            }),
            const SizedBox(height: 10),
            Text('Ngày sinh nhật',
                style: GoogleFonts.nunito(
                    color: AppColors.greyColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            MePickDate(
              initDateTime: (state.dateTime == '' || state.dateTime == null)
                  ? DateTime.now()
                  : DateFormat("dd-MM-yyyy").parse(state.dateTime!),
              func: (DateTime? value) {
                final dateTime =
                    value == null ? null : dateFormat.format(value);
                context
                    .read<DetailProfileCubit>()
                    .addNewEvent(DetailProfileEnum.dateTime, dateTime);
              },
            ),
            const SizedBox(height: 20),
            Text('Giới tính',
                style: GoogleFonts.nunito(
                    color: AppColors.greyColor, fontWeight: FontWeight.bold)),
            MeDropDown(
                value: genderValue,
                items: const ['male', 'female'],
                func: (value) {
                  genderValue = value;
                  context
                      .read<DetailProfileCubit>()
                      .addNewEvent(DetailProfileEnum.gender, genderValue);
                }),
          ]),
        );
      },
    );
  }

  String? validateFunc(value, {required EditFieldProfileEnum type}) {
    switch (type) {
      case EditFieldProfileEnum.firstName:
      case EditFieldProfileEnum.lastName:
        if (Validate().isInvalidName(value)) {
          return 'Tên không hợp lệ';
        }
        break;
      case EditFieldProfileEnum.phoneNumber:
        if (Validate().isInvalidPhoneNumber(value)) {
          return 'Số điện thoại bao gồm 10 số';
        }
        break;
      default:
    }
    return null;
  }

  Widget textField(String title, String? Function(String) funcValidate,
      {bool? isEnabled,
      Function()? onChanged,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.nunito(
                  color: AppColors.greyColor, fontWeight: FontWeight.bold)),
          MeTextField(
              isEnabled: isEnabled,
              functionValidation: funcValidate,
              callFuncOnChange: onChanged,
              textEditingController: controller),
        ],
      ),
    );
  }
}
