import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/seller/cubit/seller_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';

class SellerTabCategory extends StatelessWidget {
  const SellerTabCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      bloc: context.read<SellerCubit>()..loadCategories(),
      buildWhen: (previous, current) =>
          previous.categories != current.categories,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: AppColors.whiteColor,
          child: Column(
            children: state.categories
                .map((e) => _CategoryInkwell(
                      category: e,
                      sellerId: state.profileSeller.id,
                    ))
                .toList(),
          ),
        );
        // return ComponentCategoryVerticalWidget(
        //   categories: state.categories,
        // );
      },
    );
  }
}

class _CategoryInkwell extends StatelessWidget {
  const _CategoryInkwell({required this.category, required this.sellerId});
  final Category category;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Paths.sellerProductsOfCategoryScreen, extra: {
          'sellerId': sellerId,
          'category': category,
        });
      },
      child: Container(
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAssets.fkImHarryPotter1,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Text(
                  category.name,
                  style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Icon(
                  MaterialCommunityIcons.chevron_right,
                  color: AppColors.greyColor,
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
