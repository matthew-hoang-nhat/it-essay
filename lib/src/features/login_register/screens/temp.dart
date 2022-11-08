// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:it_project/src/configs/constants/app_assets.dart';
// import 'package:it_project/src/configs/constants/app_colors.dart';
// import 'package:it_project/src/configs/constants/app_dimensions.dart';
// import 'package:it_project/src/utils/app_pages.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints.expand(),
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(
//                 AppAssets.imBackgroundImage,
//               ),
//               opacity: 0.5,
//               fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//             child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Spacer(),
//               Text(
//                 "DONT HAVE ACCESS",
//                 style: GoogleFonts.nunito(
//                   fontSize: AppDimensions.dp30,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               Text(
//                 "YOUR BAG & WISHLIST",
//                 style: GoogleFonts.nunito(
//                   fontSize: AppDimensions.dp30,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               Text(
//                 "PERSONALIZE",
//                 style: GoogleFonts.roboto(
//                   fontSize: AppDimensions.dp50,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               Text(
//                 "FOR",
//                 style: GoogleFonts.roboto(
//                   fontSize: AppDimensions.dp50,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               Text(
//                 "YOURSELF",
//                 style: GoogleFonts.roboto(
//                   fontSize: AppDimensions.dp50,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               const SizedBox(height: AppDimensions.dp100),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(AppPages.loginScreen);
//                 },
//                 child: buttonTitle(
//                     title: 'Log in',
//                     backgroundColor: AppColors.brownColor,
//                     textColor: AppColors.whiteColor),
//               ),
//               const SizedBox(
//                 height: AppDimensions.dp20,
//               ),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(AppPages.registerScreen);
//                 },
//                 child: buttonTitle(
//                   title: 'Register',
//                   backgroundColor: AppColors.whiteColor,
//                 ),
//               ),
//               const SizedBox(height: AppDimensions.dp20),
//               Center(
//                 child: InkWell(
//                   splashFactory: NoSplash.splashFactory,
//                   borderRadius: BorderRadius.circular(100),
//                   onTap: () {
//                     Get.toNamed(AppPages.mainScreen);
//                   },
//                   child: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Image.asset(AppAssets.icGoogle),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: AppDimensions.dp20),
//             ],
//           ),
//         )),
//       ),
//     );
//   }

//   Widget buttonTitle(
//       {required String title,
//       required Color backgroundColor,
//       Color? textColor}) {
//     return Container(
//       alignment: Alignment.center,
//       height: AppDimensions.dp50,
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppDimensions.dp20,
//         vertical: AppDimensions.dp10,
//       ),
//       decoration: BoxDecoration(
//           color: backgroundColor, borderRadius: BorderRadius.circular(100)),
//       child: Text(
//         title,
//         style: GoogleFonts.roboto(
//           color: textColor,
//           fontSize: AppDimensions.dp20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
