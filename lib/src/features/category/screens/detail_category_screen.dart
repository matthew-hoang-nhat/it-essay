import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/category/cubit/detail_category_cubit.dart';
import 'package:it_project/src/features/category/widgets/component_category_product_vertical_widget.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/widgets/cart_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailCategoryScreen extends StatelessWidget {
  const DetailCategoryScreen({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailCategoryCubit(slugCategory: category.slug!)..loadProducts(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          // title: SearchBar(
          //     hintText: category.name,
          //     textEditingController: TextEditingController()),
          title: Text(category.name),
          // actions: [cartButton(context)],
          actions: const [CartButton()],
        ),
        body: SafeArea(
            child: Column(
          children: [
            const ComponentCategoryProductVerticalWidget(),
            BlocBuilder<DetailCategoryCubit, DetailCategoryState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return SizedBox(
                    height: 50,
                    child: LoadingAnimationWidget.waveDots(
                        color: AppColors.primaryColor, size: 50),
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<DetailCategoryCubit, DetailCategoryState>(
              buildWhen: (previous, current) =>
                  previous.isEmpty != current.isEmpty,
              builder: (context, state) {
                if (state.isEmpty) {
                  return const Expanded(
                      child: Text('Danh mục này chưa có sản phẩm'));
                }

                return Container();
              },
            ),
          ],
        )),
      ),
    );
  }
}
