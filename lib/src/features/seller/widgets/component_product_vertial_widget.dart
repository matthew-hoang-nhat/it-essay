import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';

class ComponentProductVerticalWidget extends StatelessWidget {
  const ComponentProductVerticalWidget({Key? key, required this.products})
      : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppColors.whiteColor,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          itemBuilder: (context, index) {
            if (index % 2 != 0) return Container();
            final productOdd = products[index];
            final productEven =
                (index + 1 <= products.length - 1) ? products[index + 1] : null;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2.5),
              child: Row(
                children: [
                  Flexible(
                    child: ProductWidget(
                      isBorder: true,
                      product: productOdd,
                      isHeart: false,
                    ),
                  ),
                  const SizedBox(width: 5),
                  productEven == null
                      ? Flexible(child: Container())
                      : Flexible(
                          child: InkWell(
                              onTap: () {
                                // context.push(Paths.productScreen,
                                //     extra: productEven);
                              },
                              child: ProductWidget(
                                product: productEven,
                                isBorder: true,
                                isHeart: false,
                              )
                              //  ProductWidget(
                              //   product: BriefProductModel(
                              //       mainCategory:
                              //           categoryEven.category.name,
                              //       name: categoryEven.name,
                              //       price: categoryEven.price,
                              //       productImage: categoryEven
                              //           .productImages.first.fileLink,
                              //       discountPercent:
                              //           categoryEven.discountPercent),
                              //   isHeart: false,
                              //   isBorder: true,
                              // ),
                              ),
                        ),
                ],
              ),
            );
          }),
    );
  }
}
