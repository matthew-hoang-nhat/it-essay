// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:it_project/src/configs/constants/app_assets.dart';
// import 'package:it_project/src/configs/constants/app_colors.dart';
// import 'package:it_project/src/features/search/widgets/concrete_search_bar.dart';
// import 'package:it_project/src/features/seller/cubit/seller_cubit.dart';
// import 'package:it_project/src/utils/remote/model/product/info_data.dart';
// import 'package:it_project/src/utils/remote/model/product/logo_data.dart';
// import 'package:it_project/src/utils/remote/model/product/seller.dart';

// class SellerScreen extends StatelessWidget {
//   SellerScreen({super.key});
//   final Seller seller = Seller(
//       infoData: InfoData(name: 'Tên sốp'),
//       logoData: LogoData(fileLink: ''),
//       userId: '6362ad661b406f830c670f3a');
//   @override
//   Widget build(BuildContext context) {
//     final bloc = SellerCubit(sellerId: seller.userId!);
//     // ..loadProducts()
//     // ..settingController();

//     return BlocProvider(
//       create: (context) => bloc,
//       child: Scaffold(
//         // appBar: AppBar(
//         // foregroundColor: AppColors.whiteColor,
//         // backgroundColor: AppColors.primaryColor,
//         // title: Text(seller.infoData.name),
//         //   actions: [cartButton(context)],
//         // ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           controller: bloc.state.controller,
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   briefInfoSeller(context),
//                   recommendProductComponent(),
//                   imagePoster(),
//                   // const ComponentProductsOfSellerWidget(),
//                   // BlocBuilder<SellerCubit, SellerState>(
//                   //   bloc: bloc,
//                   //   buildWhen: (previous, current) =>
//                   //       previous.isEmpty != current.isEmpty,
//                   //   builder: (context, state) {
//                   //     if (state.isEmpty == false) return Container();
//                   //     return const Expanded(
//                   //         child: Text('Danh mục này chưa có sản phẩm'));
//                   //   },
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   briefInfoSeller(context) {
//     return SizedBox(
//       height: 300,
//       child: Stack(
//         children: [
//           Stack(children: <Widget>[
//             SizedBox(
//               height: 250,
//               child: Image.asset(
//                 AppAssets.fkImHarryPotter2,
//                 width: double.infinity,
//                 height: 250,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Container(
//               height: 250,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   gradient: LinearGradient(
//                       begin: FractionalOffset.topCenter,
//                       end: FractionalOffset.bottomCenter,
//                       colors: [
//                         Colors.grey.withOpacity(0.0),
//                         AppColors.blackColor,
//                         AppColors.blackColor,
//                       ],
//                       stops: const [
//                         0.0,
//                         0.9,
//                         1.0
//                       ])),
//             )
//           ]),
//           Container(
//             padding: EdgeInsets.only(
//                 left: 20, right: 20, top: MediaQuery.of(context).padding.top),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       MaterialCommunityIcons.arrow_left,
//                       color: AppColors.whiteColor,
//                     ),
//                     SizedBox(
//                       height: 50,
//                       width: 300,
//                       child: concreteSearchBar(context),
//                     ),
//                     Icon(
//                       MaterialCommunityIcons.dots_horizontal,
//                       color: AppColors.whiteColor,
//                     ),
//                   ],
//                 ),
//                 Row(children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: Image.asset(
//                       AppAssets.fkImHarryPotter1,
//                       height: 70,
//                       width: 70,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Baby World Store',
//                           style:
//                               GoogleFonts.nunito(color: AppColors.whiteColor),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               MaterialCommunityIcons.star,
//                               color: AppColors.yellowColor,
//                             ),
//                             Text('4.9/5',
//                                 style: GoogleFonts.nunito(
//                                     color: AppColors.whiteColor)),
//                             Text('|',
//                                 style: GoogleFonts.nunito(
//                                     color: AppColors.whiteColor)),
//                             Text('15 người theo dõi',
//                                 style: GoogleFonts.nunito(
//                                     color: AppColors.whiteColor))
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.whiteBrownColor)),
//                     child: Row(children: [
//                       Icon(
//                         MaterialCommunityIcons.plus,
//                         color: AppColors.whiteColor,
//                       ),
//                       Text(
//                         'Theo dõi',
//                         style: GoogleFonts.nunito(color: AppColors.whiteColor),
//                       )
//                     ]),
//                   )
//                 ]),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   recommendProductComponent() {
//     return Container();
//   }

//   imagePoster() {
//     return Container();
//   }
// }
