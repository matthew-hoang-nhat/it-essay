import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/search/cubit/detail_search_cubit.dart';
import 'package:it_project/src/features/search/widgets/component_search_product_vertical.dart';
import 'package:it_project/src/features/search/widgets/search_bar.dart';
import 'package:it_project/src/widgets/cart_button.dart';

class DetailSearchScreen extends StatelessWidget {
  const DetailSearchScreen({super.key, required this.textSearch});
  // const DetailSearchScreen({super.key, this.textSearch = 'product'});
  final String textSearch;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailSearchCubit()..loadPageProducts(textSearch),
      // create: (context) => DetailSearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: InkWell(
              onTap: () {
                context.pop();
              },
              child: SearchBar(
                isEnabled: false,
                textEditingController: TextEditingController()
                  ..text = textSearch,
              )),
          actions: [cartButton(context)],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                ComponentSearchProductVertical(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // BlocBuilder<SearchCubit, SearchState> showProducts(SearchCubit bloc) {
  //   return BlocBuilder<SearchCubit, SearchState>(
  //     buildWhen: (previous, current) {
  //       return previous.products != current.products;
  //     },
  //     bloc: bloc,
  //     builder: (context, state) {
  //       return SizedBox(
  //         height: 300,
  //         child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: bloc.state.products.length,
  //             itemBuilder: (context, index) {
  //               final product = bloc.state.products.elementAt(index);
  //               return ProductWidget(
  //                   product: BriefProductModel(
  //                     mainCategory: product.category.name,
  //                     name: product.name,
  //                     price: product.price,
  //                     discountPercent: 20,
  //                     productImage: product.productImages.first.fileLink,
  //                   ),
  //                   isHeart: false);
  //             }),
  //       );
  //     },
  //   );
  // }

}
