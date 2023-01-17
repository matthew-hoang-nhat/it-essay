import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';

import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';
import 'package:it_project/src/features/main/home/widgets/component_category_horizontal_widget.dart';
import 'package:it_project/src/features/main/home/widgets/component_flash_sale_widget.dart';
import 'package:it_project/src/features/main/home/widgets/component_product_vertical.dart';
import 'package:it_project/src/features/search/widgets/concrete_search_bar.dart';
import 'package:it_project/src/widgets/cart_button.dart';

import 'widgets/component_top_seller_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarHome(context),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: context.read<HomeCubit>().controller,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                  onTap: () {
                    context.push(Paths.preSearchScreen);
                  },
                  child: poster()),
              meDivider(),
              const ComponentCategoryHorizontalWidget(),
              meDivider(),
              const ComponentFlashSaleWidget(),
              meDivider(),
              if (isFuture == true) const ComponentSellerWidget(),
              meDivider(),
              Container(
                color: AppColors.whiteGreyColor,
                child: const ComponentProductVertical(),
              )
            ]),
          ),
        ));
  }

  meDivider() {
    return Container(
      height: 10,
      width: double.infinity,
      color: AppColors.whiteGreyColor,
    );
  }

  Container poster() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 300,
        width: double.infinity,
        color: AppColors.whiteColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            AppAssets.imgPoster,
            fit: BoxFit.cover,
          ),
        ));
  }

  AppBar appBarHome(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      actions: [
        Expanded(
            child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(Paths.preSearchScreen);
                },
                child: concreteSearchBar())),
        const CartButton()
        // cartButton(context),
      ],
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
