import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/category/cubit/detail_category_cubit.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';

class ComponentCategoryProductVerticalWidget extends StatelessWidget {
  const ComponentCategoryProductVerticalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCategoryCubit, DetailCategoryState>(
        bloc: context.read<DetailCategoryCubit>(),
        // buildWhen: (previous, current) => previous.products != current.products,
        builder: (context, state) {
          // if (state.isShowProducts == false) return Container();
          final products = state.products;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
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
                              isHeart: false,
                              isBorder: true,
                            ),
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
                                    isHeart: false,
                                    isBorder: true,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
