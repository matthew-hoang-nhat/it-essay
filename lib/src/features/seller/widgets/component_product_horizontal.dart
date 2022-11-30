import 'package:flutter/cupertino.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';

class ComponentProductHorizontal extends StatelessWidget {
  const ComponentProductHorizontal({
    super.key,
    required this.products,
    required this.categorySlug,
    required this.maxProductInARow,
  });
  final String categorySlug;
  final int maxProductInARow;
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (var index = 0;
          index < products.length && index < maxProductInARow;
          index++)
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ProductWidget(
            product: products[index],
            isBorder: true,
            isHeart: false,
          ),
        )),
      for (var index = 0; index < maxProductInARow - products.length; index++)
        Flexible(child: Container()),
    ]);
  }
}
