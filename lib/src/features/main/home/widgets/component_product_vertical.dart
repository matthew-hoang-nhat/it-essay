import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';

class ComponentProductVertical extends StatelessWidget {
  const ComponentProductVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
        bloc: bloc..getProducts(),
        builder: (context, state) {
          if (bloc.state.products.isEmpty) return Container();
          final products = bloc.state.products;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (index % 2 != 0) return Container();
                final productOdd = products[index];
                final productEven = (index + 1 <= products.length - 1)
                    ? products[index + 1]
                    : null;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            context.push(Paths.productScreen,
                                extra: productOdd);
                          },
                          child: ProductWidget(
                              product: BriefProductModel(
                                  slug: productOdd.slug,
                                  mainCategory: productOdd.category.name,
                                  name: productOdd.name,
                                  price: productOdd.price,
                                  productImage:
                                      productOdd.productImages.first.fileLink,
                                  discountPercent: productOdd.discountPercent),
                              isHeart: false),
                        ),
                      ),
                      const SizedBox(width: 5),
                      productEven == null
                          ? Flexible(child: Container())
                          : Flexible(
                              child: InkWell(
                                onTap: () {
                                  context.push(Paths.productScreen,
                                      extra: productEven);
                                },
                                child: ProductWidget(
                                    product: BriefProductModel(
                                        slug: productEven.slug,
                                        mainCategory: productEven.category.name,
                                        name: productEven.name,
                                        price: productEven.price,
                                        productImage: productEven
                                            .productImages.first.fileLink,
                                        discountPercent:
                                            productEven.discountPercent),
                                    isHeart: false),
                              ),
                            ),
                    ],
                  ),
                );
              });
        });
  }
}
