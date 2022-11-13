import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/category/cubit/category_cubit.dart';
import 'package:it_project/src/features/category/widgets/component_category_vertical_widget.dart';
import 'package:it_project/src/widgets/cart_button.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..loadPage(CategoryEnum.categories),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          actions: [cartButton(context)],
          title: const Text('Danh mục'),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              ComponentCategoryVerticalWidget(),
            ],
          ),
        )),
      ),
    );
  }
}
