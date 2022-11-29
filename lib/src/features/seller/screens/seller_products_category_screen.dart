import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/seller/cubit/category_product_cubit.dart';
import 'package:it_project/src/features/seller/widgets/component_product_vertial_widget.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';

class SellerProductsInCategoryScreen extends StatelessWidget {
  const SellerProductsInCategoryScreen({
    super.key,
    required this.sellerId,
    required this.category,
  });
  final String sellerId;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryProductCubit(
        categoryId: category.id!,
        sellerId: sellerId,
      )..loadProducts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(category.name),
        ),
        body: BlocBuilder<CategoryProductCubit, CategoryProductState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ComponentProductVerticalWidget(
                products: state.products,
              ),
            );
          },
        ),
      ),
    );
  }
}
