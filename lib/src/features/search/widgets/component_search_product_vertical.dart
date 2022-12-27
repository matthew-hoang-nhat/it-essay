import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';

class ComponentSearchProductVertical extends StatelessWidget {
  const ComponentSearchProductVertical({Key? key, required this.products})
      : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  child: InkWell(
                    onTap: () {
                      context.push(Paths.productScreen, extra: productOdd);
                    },
                    child: ProductWidget(
                      product: productOdd,
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
                            isHeart: false,
                            isBorder: true,
                          ),
                        ),
                      ),
              ],
            ),
          );
        });
  }
}
