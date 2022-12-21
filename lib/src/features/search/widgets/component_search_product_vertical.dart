import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ComponentSearchProductVertical extends StatelessWidget {
  const ComponentSearchProductVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<DetailSearchCubit>();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (previous, current) =>
                previous.products != current.products,
            builder: (context, state) {
              // if (state.isShowProducts == false) return Container();
              final products = state.products;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                                  product: productOdd,
                                  // product: BriefProductModel(
                                  //     slug: productOdd.slug,
                                  //     mainCategory: productOdd.category.name,
                                  //     name: productOdd.name,
                                  //     price: productOdd.price,
                                  //     productImage:
                                  //         productOdd.productImages.first.fileLink,
                                  //     discountPercent: productOdd.discountPercent),
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
                                        product: productEven,
                                        // product: BriefProductModel(
                                        //     slug: productEven.slug,
                                        //     mainCategory: productEven.category.name,
                                        //     name: productEven.name,
                                        //     price: productEven.price,
                                        //     productImage: productEven
                                        //         .productImages.first.fileLink,
                                        //     discountPercent:
                                        //         productEven.discountPercent),
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
            }),
        BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) =>
              previous.isLoadingMore != current.isLoadingMore,
          builder: (context, state) {
            if (state.isLoadingMore) {
              return Container(
                  child: LoadingAnimationWidget.waveDots(
                      color: AppColors.primaryColor, size: 50));
            }
            return Container();
          },
        )
      ],
    );
  }
}
