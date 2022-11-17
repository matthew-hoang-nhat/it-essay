// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:it_project/src/configs/constants/app_assets.dart';
// import 'package:it_project/src/configs/constants/app_colors.dart';
// import 'package:it_project/src/configs/routes/routes_name_app.dart';
// import 'package:it_project/src/features/profile/cubit/detail_profile_cubit.dart';
// import 'package:it_project/src/features/profile/screens/edit_field_profile_screen.dart';

// class DetailProfileScreen extends StatelessWidget {
//   const DetailProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bloc = DetailProfileCubit()..getProfileUser();
//     return BlocProvider<DetailProfileCubit>(
//       create: (context) => bloc,
//       child: Scaffold(
//         // backgroundColor: AppColors.whiteGreyColor,
//         appBar: AppBar(
//           // backgroundColor: AppColors.primaryColor,
//           title: Text(
//             'Sửa hồ sơ',
//             style: GoogleFonts.nunito(color: AppColors.brownColor),
//           ),
//           actions: const [],
//         ),
//         body: Column(
//           children: [
//             Column(
//               children: [
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     ImageFiltered(
//                       imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
//                       child: ShaderMask(
//                         shaderCallback: (rect) {
//                           return LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Colors.white,
//                                 // Colors.white,
//                                 // Colors.white,
//                                 AppColors.primaryColor,
//                                 // AppColors.primaryColor,

//                                 Colors.black.withOpacity(0)
//                               ],
//                               stops: const [
//                                 0.1,
//                                 0.3,
//                                 0.75
//                               ]).createShader(rect);
//                         },
//                         blendMode: BlendMode.darken,
//                         child: Container(
//                           width: double.infinity,
//                           height: 200,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: Image.asset(
//                           AppAssets.fkImHarryPotter1,
//                           height: 100,
//                           width: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Container(
//                     width: double.infinity,
//                     color: AppColors.brownColor.withOpacity(0.5),
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Chạm để thay đổi',
//                       style: GoogleFonts.nunito(color: AppColors.whiteColor),
//                     )),
//               ],
//             ),
//             BlocBuilder<DetailProfileCubit, DetailProfileState>(
//               bloc: bloc,
//               builder: (context, state) {
//                 print('rebuild blocBuilder');
//                 return Container(
//                   color: AppColors.whiteColor,
//                   child: Column(children: [
//                     rowContent(
//                       'Tên',
//                       state.profileUser?.info.lastName,
//                       () {
//                         context.push(Paths.editProfileScreen, extra: {
//                           'content': state.profileUser?.info.lastName,
//                           'type': EditFieldProfileEnum.name,
//                         });
//                       },
//                     ),
//                     rowContent(
//                       'Số điện thọai',
//                       state.profileUser?.contact.phone,
//                       () {
//                         context.push(Paths.editProfileScreen, extra: {
//                           'content': state.profileUser?.contact.phone,
//                           'type': EditFieldProfileEnum.phoneNumber,
//                         });
//                       },
//                     ),
//                     rowContent(
//                       'Email',
//                       'mattheuhtn@gmail.com',
//                       () {
//                         context.push(Paths.editProfileScreen, extra: {
//                           'type': EditFieldProfileEnum.email,
//                           'content': 'mattheuhtn@gmail.com',
//                         });
//                       },
//                     ),
//                   ]),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             Container(
//               color: AppColors.whiteColor,
//               child: Column(children: [
//                 rowContent('Giới tính', 'Nam', () {}),
//                 rowContent('Ngày sinh', '12/11/2001', () {}),
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   rowContent(String leading, String? trailing, Function() func) {
//     return InkWell(
//       onTap: func,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Row(
//               children: [
//                 Text(leading),
//                 const Spacer(),
//                 trailing == null
//                     ? Text(
//                         'Thiết lập ngay',
//                         style: GoogleFonts.nunito(color: AppColors.greyColor),
//                       )
//                     : Text(trailing),
//                 Icon(
//                   MaterialCommunityIcons.chevron_right,
//                   color: AppColors.greyColor,
//                 )
//               ],
//             ),
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }
// }