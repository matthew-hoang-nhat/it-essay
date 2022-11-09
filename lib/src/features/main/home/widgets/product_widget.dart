import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';

import 'package:it_project/src/widgets/product_general/product_general_model.dart';
import 'package:it_project/src/widgets/product_general/product_general_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (bloc.state.products.isEmpty) return Container();
          final products = bloc.state.products;
          return SizedBox(
            height: 300,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(Paths.productScreen);
                    },
                    child: ProductGeneralWidget(
                        product: ProductGeneralModel(
                            mainCategory: products[index].category.name,
                            name: products[index].name,
                            price: products[index].price.toString(),
                            productImage:
                                products[index].productImages.first.fileLink,
                            priceAfterDecrement: ''),
                        isHeart: false),
                  );
                }),
          );
        });
  }
}
