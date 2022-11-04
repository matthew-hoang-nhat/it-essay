// import 'package:flutter/material.dart';
// import 'package:flutter_lorem/flutter_lorem.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:it_project/src/ui/home_screen/home_viewmodel.dart';
// import 'package:it_project/src/ui/home_screen/search_bar.dart';
// import 'package:it_project/src/ui/widgets/ad_post.dart';
// import 'package:it_project/src/ui/widgets/tag/tag.dart';
// import 'package:it_project/src/utils/app_assets.dart';
// import 'package:it_project/src/utils/app_colors.dart';
// import 'package:it_project/src/utils/app_dimensions.dart';

// class HomeScreen extends GetView<HomeViewModel> {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 userBar(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 searchBar(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 quoteOfTheDay(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 readeToday(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 topBooks(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ]),
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Special for you'),
//                       TextButton(onPressed: () {}, child: const Text('See all'))
//                     ],
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: const [
//                       SizedBox(
//                         width: 20,
//                       ),
//                       AdPost(),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       AdPost(),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       AdPost(),
//                       SizedBox(
//                         width: 20,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//           ],
//         ),
//       )),
//     );
//   }

//   Column readeToday() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Reade today',
//           style: GoogleFonts.nunito(
//               fontWeight: FontWeight.bold, fontSize: AppDimensions.dp20),
//         ),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(AppDimensions.dp20),
//           child: Image.asset(
//             AppAssets.imgHarryJpg,
//             width: double.infinity,
//             height: 150,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ],
//     );
//   }

//   Column topBooks() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Top 10 books for self-development',
//           style: GoogleFonts.nunito(
//               fontWeight: FontWeight.bold, fontSize: AppDimensions.dp20),
//         ),
//         Wrap(
//           runSpacing: 5,
//           spacing: 10,
//           children: const [
//             Tag(
//               text: 'Education',
//             ),
//             Tag(
//               text: 'Self-development',
//             ),
//             Tag(
//               text: 'Psychology',
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   Row searchBar() => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: SearchBar(
//               textEditingController: TextEditingController(),
//             ),
//           ),
//           const SizedBox(
//             width: AppDimensions.dp20,
//           ),
//           Image.asset(
//             AppAssets.icCart,
//             width: 30,
//           ),
//         ],
//       );

//   Row userBar() => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Hello, Alexa',
//             style: GoogleFonts.nunito(
//               fontSize: AppDimensions.dp30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Container(
//               padding: const EdgeInsets.all(AppDimensions.dp5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   color: AppColors.brownColor),
//               child: Image.asset(
//                 AppAssets.icUserFilled,
//                 width: AppDimensions.dp40,
//                 color: AppColors.whiteColor,
//               )),
//         ],
//       );

//   quoteOfTheDay() => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(AppDimensions.dp20),
//             color: AppColors.whiteBlueColor),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(
//             'Quote of the Day',
//             style: GoogleFonts.nunito(
//               fontSize: AppDimensions.dp20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text('"${lorem(paragraphs: 1, words: 20)}"'),
//           const Align(alignment: Alignment.centerRight, child: Text('O. Wild'))
//         ]),
//       );
// }
