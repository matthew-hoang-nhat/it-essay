// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/seller/cubit/seller_cubit.dart';
import 'package:it_project/src/features/seller/widgets/component_product_horizontal.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';

class SellerTabShop extends StatelessWidget {
  const SellerTabShop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      bloc: context.read<SellerCubit>(),
      buildWhen: (previous, current) =>
          previous.categories != current.categories,
      builder: (context, state) {
        return Column(
          children: [
            _ComponentSellerTabShop(
              categories: state.categories,
              sellerId: state.profileSeller.id,
            ),
          ],
        );
      },
    );
  }
}

class _ComponentSellerTabShop extends StatelessWidget {
  final List<Category> categories;
  final String sellerId;

  const _ComponentSellerTabShop({
    Key? key,
    required this.categories,
    required this.sellerId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
        bloc: context.read<SellerCubit>(),
        buildWhen: (previous, current) =>
            previous.productsOfCategory != current.productsOfCategory,
        builder: (context, state) {
          final categories = state.categories;
          return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 0),
              children: [
                for (var index = 0; index < categories.length; index++)
                  if (state.productsOfCategory[categories[index].id] != null)
                    productsCategory(
                        context,
                        categories[index].name,
                        categories[index],
                        state.productsOfCategory[categories[index].id])
              ]);
        });
  }

  Widget productsCategory(
    context,
    name,
    Category category,
    products,
  ) {
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(name,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                InkWell(
                  onTap: () {
                    GoRouter.of(context)
                        .push(Paths.sellerProductsOfCategoryScreen, extra: {
                      'sellerId': sellerId,
                      'category': category,
                    });
                  },
                  child: Text('Xem tất cả',
                      style: GoogleFonts.nunito(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primaryColor)),
                ),
                Icon(
                  MaterialCommunityIcons.chevron_right,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 300,
            child: ComponentProductHorizontal(
              maxProductInARow: 2,
              products: [
                for (var index = 0;
                    index < 2 && index < products.length;
                    index++)
                  products.elementAt(index)
              ],
              categorySlug: category.id!,
            ),
          )
        ],
      ),
    );
  }
}
