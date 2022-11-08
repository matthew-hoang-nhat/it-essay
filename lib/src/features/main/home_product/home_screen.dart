import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/home_product/cubit/product_cubit.dart';
import 'package:it_project/src/features/main/home_product/widgets/category_widget.dart';
import 'package:it_project/src/features/main/home_product/widgets/product_widget.dart';
import 'package:it_project/src/utils/app_shared.dart';

import 'package:it_project/src/widgets/product_general/product_general_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ProductCubit();
    bloc.productCallApi();

    return Scaffold(
        body: SafeArea(
      child: BlocProvider<ProductCubit>(
        create: (context) => bloc,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  getIt<AppShared>().clear();
                },
                child: const Text('Log out')),
            appBarHome(context),
            const ProductWidget(),
            const CategoryWidget(),
            // Expanded(
            //   child: SingleChildScrollView(
            //     physics: const BouncingScrollPhysics(),
            //     child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           // SingleChildScrollView(
            //           //   scrollDirection: Axis.horizontal,
            //           //   physics: const BouncingScrollPhysics(),
            //           //   child: Row(children: [
            //           //     const SizedBox(width: AppDimensions.dp20),
            //           //     bigImage(AppAssets.fkImHarryPotter1),
            //           //     const SizedBox(
            //           //       width: AppDimensions.dp20,
            //           //     ),
            //           //     bigImage(AppAssets.fkImHarryPotter2),
            //           //     const SizedBox(
            //           //       width: AppDimensions.dp20,
            //           //     ),
            //           //     bigImage(AppAssets.fkImHarryPotter3),
            //           //   ]),
            //           // ),
            //           const SizedBox(height: 20),
            //           // Padding(
            //           //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //           //   child: Column(
            //           //     crossAxisAlignment: CrossAxisAlignment.start,
            //           //     children: [
            //           //       Text(
            //           //         'Shop by Category',
            //           //         style:
            //           //             GoogleFonts.nunito(color: AppColors.greyColor),
            //           //       ),
            //           //       Text(
            //           //         'CATEGORIES',
            //           //         style: GoogleFonts.nunito(
            //           //             fontSize: AppDimensions.dp30,
            //           //             fontWeight: FontWeight.bold),
            //           //       ),
            //           //     ],
            //           //   ),
            //           // ),
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           // SingleChildScrollView(
            //           //   scrollDirection: Axis.horizontal,
            //           //   physics: const BouncingScrollPhysics(),
            //           //   child: Row(
            //           //     //   spacing: 20,
            //           //     //   runSpacing: 20,
            //           //     children: [
            //           //       const SizedBox(width: 20),
            //           //       categoryWidget(context, 'Thiếu nhi'),
            //           //       const SizedBox(width: 20),
            //           //       categoryWidget(context, 'Phát triển bản thân'),
            //           //       const SizedBox(width: 20),
            //           //       categoryWidget(context, 'Tiểu thuyết'),
            //           //       const SizedBox(width: 20),
            //           //       categoryWidget(context, 'Văn học'),
            //           //       const SizedBox(width: 20),
            //           //       categoryWidget(context, 'Phát triển bản thân'),
            //           //       const SizedBox(width: 20),
            //           //       categoryWidget(context, 'Tiểu thuyết'),
            //           //       const SizedBox(width: 20),
            //           //     ],
            //           //   ),
            //           // ),
            //           const SizedBox(height: 20),
            //           BlocProvider<ProductCubit>(
            //               create: (context) => bloc,
            //               child: const ProductWidget()),
            //           const SizedBox(height: 20),
            //         ]),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }

  Padding appBarHome(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            AppAssets.icLogo,
            height: AppDimensions.dp30,
          ),
          const SizedBox(width: 20),
          Text(
            'Hi Matthew',
            style: GoogleFonts.nunito(
              fontSize: AppDimensions.dp20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              // getIt<AppRouter>()
              //     .router
              //     .push(Paths.cartScree, extra: mockProductGeneralModel);
              GoRouter.of(context)
                  .push(Paths.cartScreen, extra: mockProductGeneralModel);
            },
            // child: Image.asset(
            //   AppAssets.icCartFilled,
            //   height: 30,
            // ),
            child: const Icon(MaterialCommunityIcons.cart),
          ),
        ],
      ),
    );
  }

  Widget bigImage(String urlAssets) {
    return SizedBox(
      width: 200,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.dp20),
        child: Image.asset(
          urlAssets,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
