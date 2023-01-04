import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/cubit/main_cubit.dart';
import 'package:it_project/src/widgets/me_alert_dialog.dart';

import '../../app/cubit/app_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppCubit>().fetchFUser();
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteGreyColor.withOpacity(0.3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            infoUserCard(sizeWidth),
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  context.push(
                      '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}');
                },
                child: orderCard()),
            someChoice(context),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Padding someChoice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor),
            child: Column(children: [
              ListTile(
                leading: Icon(
                  MaterialCommunityIcons.account,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Thông tin cá nhân'),
                onTap: () {
                  context.push(Paths.detailProfileScreen);
                },
                trailing: const Icon(MaterialCommunityIcons.chevron_right),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  MaterialCommunityIcons.clipboard_text_clock_outline,
                  color: AppColors.primaryColor,
                ),
                onTap: () {
                  context.push(
                      '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}');
                },
                title: const Text('Đơn hàng'),
                trailing: const Icon(
                  MaterialCommunityIcons.chevron_right,
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  context.push(Paths.addressScreen);
                },
                leading: Icon(
                  MaterialCommunityIcons.map,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Địa chỉ'),
                trailing: const Icon(
                  MaterialCommunityIcons.chevron_right,
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  context.push(
                      '${Paths.mainScreen}/${Paths.sChangePasswordScreen}');
                },
                leading: Icon(
                  MaterialCommunityIcons.form_textbox_password,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Đổi mật khẩu'),
                trailing: const Icon(
                  MaterialCommunityIcons.chevron_right,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor),
            child: Column(children: [
              ListTile(
                leading: Icon(
                  MaterialCommunityIcons.projector_screen_variant,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Điều khoản và chính sách'),
                onTap: () {
                  // context.push('${Paths.mainScreen}/${Paths.sPrivacyScreen}');
                },
                trailing: const Icon(MaterialCommunityIcons.chevron_right),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  MaterialCommunityIcons.chat_question,
                  color: AppColors.primaryColor,
                ),
                onTap: () {
                  // context.push('${Paths.mainScreen}/${Paths.sAboutMeScreen}');
                },
                title: const Text('Về chúng tôi'),
                trailing: const Icon(
                  MaterialCommunityIcons.chevron_right,
                ),
              ),
              const Divider(),
              // ListTile(
              //   onTap: () {},
              //   leading: Icon(
              //     MaterialCommunityIcons.target,
              //     color: AppColors.primaryColor,
              //   ),
              //   title: const Text('Tính năng thử nghiệm'),
              //   trailing: const SwitchWidget(),
              // )
            ]),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor),
            child: ListTile(
              title: Text(
                'Đăng xuất',
                style: GoogleFonts.nunito(color: AppColors.redColor),
              ),
              trailing: const Icon(MaterialCommunityIcons.chevron_right),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => MeAlertDialog(
                            notificationTitle: RichText(
                                text: TextSpan(
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: AppColors.brownColor),
                                    children: [
                                  const TextSpan(text: 'Bạn có muốn '),
                                  TextSpan(
                                      text: 'đăng xuất?',
                                      style: GoogleFonts.nunito(
                                        color: AppColors.redColor,
                                      )),
                                ])),
                            redActionTexts: {
                              'Có': () {
                                context.read<AppCubit>().logOut();

                                Navigator.pop(context);
                                context.read<MainCubit>().reloadMainScreen();
                              }
                            },
                            normalActionTexts: {
                              'Không': () {
                                Navigator.pop(context);
                              }
                            }));
              },
            ),
          ),
        ],
      ),
    );
  }

  Container orderCard() {
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(children: [
        Row(
          children: [
            Icon(
              MaterialCommunityIcons.billboard,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 10),
            const Text('Đơn mua'),
            const Spacer(),
            Text(
              'Xem lịch sử mua hàng',
              style:
                  GoogleFonts.nunito(fontSize: 12, color: AppColors.greyColor),
            ),
            Icon(
              MaterialCommunityIcons.chevron_right,
              color: AppColors.greyColor,
            )
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconText('Chờ xác nhận', MaterialCommunityIcons.wallet_giftcard),
            iconText('Chờ lấy hàng', MaterialCommunityIcons.boxing_glove),
            iconText('Đang giáo', MaterialCommunityIcons.bus),
            iconText(
                'Đánh giá', MaterialCommunityIcons.star_box_multiple_outline),
          ],
        )
      ]),
    );
  }

  Stack infoUserCard(double sizeWidth) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
          margin: const EdgeInsets.only(bottom: 50),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      // Colors.white,
                      // Colors.white,
                      AppColors.primaryColor,
                      AppColors.primaryColor,
                      // AppColors.primaryColor,

                      Colors.black.withOpacity(0)
                    ],
                    stops: const [
                      0.1,
                      0.3,
                      0.7,
                      0.75
                    ]).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                width: double.infinity,
                height: 200,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.fUser == null) {
              return Container(
                height: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              );
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  context.push(Paths.detailProfileScreen);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: AppColors.whiteColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.primaryColor),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: state.fUser!.avatar == null
                                      ? Container(
                                          color: AppColors.whiteColor,
                                          width: sizeWidth * 1 / 5,
                                          height: sizeWidth * 1 / 5,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: state.fUser!.avatar!,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: AppColors.whiteColor,
                                          ),
                                          width: sizeWidth * 1 / 5,
                                          height: sizeWidth * 1 / 5,
                                          fit: BoxFit.cover,
                                        ))),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: GoogleFonts.nunito(
                                        color: AppColors.brownColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                    TextSpan(
                                        text: (state.fUser!.firstName!)
                                            .toUpperCase()),
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                        text: (state.fUser!.lastName!)
                                            .toUpperCase()),
                                  ])),
                              Text(
                                state.fUser!.phoneNumber ?? 'Số điện thoại',
                                style: GoogleFonts.nunito(
                                    color: AppColors.greyColor),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        MaterialCommunityIcons.chess_king,
                                        color: AppColors.whiteColor,
                                        size: 15,
                                      ),
                                      Text(
                                        'Thành viên',
                                        style: GoogleFonts.nunito(
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  iconText(text, icon) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 10),
        Text(
          text,
          style: GoogleFonts.nunito(fontSize: 12),
        ),
      ],
    );
  }
}
