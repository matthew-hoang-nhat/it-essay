// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:it_project/main.dart';
// import 'package:it_project/src/configs/constants/app_colors.dart';
// import 'package:it_project/src/configs/routes/routes_name_app.dart';
// import 'package:it_project/src/features/main/cubit/main_cubit.dart';
// import 'package:it_project/src/widgets/me_alert_dialog.dart';

// import '../../app/cubit/app_cubit.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final sizeWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColors.blueColor,
//           title: const Text('Ví của tôi')),
//       // backgroundColor: AppColors.whiteGreyColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () {
//                   context.push(Paths.detailProfileScreen);
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     // color: AppColors.whiteColor,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.all(2),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: AppColors.primaryColor),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: CachedNetworkImage(
//                                 imageUrl:
//                                     'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-08/220804-elon-musk-mjf-1318-f4a5bf.jpg',
//                                 width: sizeWidth * 1 / 9,
//                                 height: sizeWidth * 1 / 9,
//                                 fit: BoxFit.cover,
//                               )
//                               // Image.asset(
//                               //   AppAssets.fkImHarryPotter1,
//                               //   width: sizeWidth * 1 / 9,
//                               //   height: sizeWidth * 1 / 9,
//                               //   fit: BoxFit.cover,
//                               // )),
//                               )),
//                       const SizedBox(width: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Hoàng Trung Nhật'.toUpperCase(),
//                             style: GoogleFonts.nunito(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '0935638415',
//                             style:
//                                 GoogleFonts.nunito(color: AppColors.greyColor),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: AppColors.whiteColor),
//                 child: Column(children: const [
//                   ListTile(
//                     leading: Icon(MaterialCommunityIcons.account),
//                     title: Text('Thông tin cá nhân'),
//                     trailing: Icon(MaterialCommunityIcons.chevron_right),
//                   ),
//                   Divider(),
//                   ListTile(
//                     leading: Icon(
//                         MaterialCommunityIcons.clipboard_text_clock_outline),
//                     title: Text('Đơn hàng'),
//                     trailing: Icon(MaterialCommunityIcons.chevron_right),
//                   ),
//                   Divider(),
//                   ListTile(
//                     leading: Icon(MaterialCommunityIcons.map),
//                     title: Text('Địa chỉ'),
//                     trailing: Icon(MaterialCommunityIcons.chevron_right),
//                   ),
//                 ]),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: AppColors.whiteColor),
//                 child: ListTile(
//                   title: Text(
//                     'Đăng xuất',
//                     style: GoogleFonts.nunito(color: AppColors.redColor),
//                   ),
//                   trailing: const Icon(MaterialCommunityIcons.chevron_right),
//                   onTap: () {
//                     showDialog(
//                         context: context,
//                         builder: (context) => MeAlertDialog(
//                                 notificationTitle: RichText(
//                                     text: TextSpan(
//                                         style: GoogleFonts.nunito(
//                                             fontSize: 16,
//                                             color: AppColors.brownColor),
//                                         children: [
//                                       const TextSpan(text: 'Bạn có muốn '),
//                                       TextSpan(
//                                           text: 'đăng xuất?',
//                                           style: GoogleFonts.nunito(
//                                             color: AppColors.redColor,
//                                           )),
//                                     ])),
//                                 redActionTexts: {
//                                   'Có': () {
//                                     getIt<AppCubit>().state.fUserLocal.logOut();
//                                     Navigator.pop(context);
//                                     context
//                                         .read<MainCubit>()
//                                         .reloadMainScreen();
//                                   }
//                                 },
//                                 normalActionTexts: {
//                                   'Không': () {
//                                     Navigator.pop(context);
//                                   }
//                                 }));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
