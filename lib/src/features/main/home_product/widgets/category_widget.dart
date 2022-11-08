import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/features/main/home_product/cubit/product_cubit.dart';
import 'package:it_project/src/widgets/category_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductCubit>();
    return BlocBuilder<ProductCubit, ProductState>(
        bloc: bloc,
        builder: (context, state) {
          if (bloc.state.categories.isEmpty) return Container();
          final products = bloc.state.categories;
          return SizedBox(
            height: 120,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return categoryWidget(
                      context, products.elementAt(index).name);
                }),
          );
        });
  }
}
