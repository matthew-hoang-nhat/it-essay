import 'package:flutter/material.dart';
import 'package:it_project/src/features/product/mock/mock_product.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';
import 'package:it_project/src/widgets/product_general/product_widget.dart';

class ComponentProductWidget extends StatelessWidget {
  const ComponentProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ProductWidget(
              product: BriefProductModel(
                  price: (mockProduct.price *
                          (100 - mockProduct.discountPercent) /
                          100)
                      .round(),
                  name: mockProduct.name,
                  discountPercent: mockProduct.discountPercent,
                  productImage: null,
                  mainCategory: mockProduct.category.name),
              isHeart: false),
          ProductWidget(
              product: BriefProductModel(
                  price: mockProduct.price,
                  name: mockProduct.name,
                  discountPercent: mockProduct.discountPercent,
                  productImage: null,
                  mainCategory: mockProduct.category.name),
              isHeart: false),
        ],
      ),
    );
    // final bloc = context.read<HomeCubit>();
    // return BlocBuilder<HomeCubit, HomeState>(
    //     bloc: bloc,
    //     builder: (context, state) {
    //       if (bloc.state.products.isEmpty) return Container();
    //       final products = bloc.state.products;
    //       return SizedBox(
    //         height: 300,
    //         child: ListView.builder(
    //             physics: const BouncingScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             itemCount: products.length,
    //             itemBuilder: (context, index) {
    //               if (index == products.length - 2) bloc.nextPage();

    //               final product = products[index];
    //               return InkWell(
    //                 onTap: () {
    //                   context.push(Paths.productScreen);
    //                 },
    //                 child: ProductGeneralWidget(
    //                     product: ProductGeneralModel(
    //                         mainCategory: product.category.name,
    //                         name: product.name,
    //                         price: product.price.toString(),
    //                         productImage: product.productImages.first.fileLink,
    //                         discountPercent: product.discountPercent),
    //                     isHeart: false),
    //               );
    //             }),
    //       );
    //     });
  }
}
