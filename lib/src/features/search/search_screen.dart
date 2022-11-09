import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/features/search/search_bar.dart';
import 'package:it_project/src/widgets/category_widget.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';
import 'package:it_project/src/widgets/product_general/product_general_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchCubit>();
    if (bloc.state.categories.isEmpty) {
      bloc.getCategories();
    }

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              imageBackground(bloc),
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).padding.top),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topBar(context),
                    SearchBar(textEditingController: TextEditingController()),
                    const SizedBox(height: 20),
                    textInImageBackground(bloc)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          categories(context, bloc),
          // extensionSearchField(),
          showProducts(bloc)
        ],
      ),
    );
  }

  BlocBuilder<SearchCubit, SearchState> showProducts(SearchCubit bloc) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) {
        return previous.products != current.products;
      },
      bloc: bloc,
      builder: (context, state) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bloc.state.products.length,
              itemBuilder: (context, index) {
                final product = bloc.state.products.elementAt(index);
                return ProductGeneralWidget(
                    product: ProductGeneralModel(
                      mainCategory: product.category.name,
                      name: product.name,
                      price: product.price.toString(),
                      priceAfterDecrement: '',
                      productImage: product.productImages.first.fileLink,
                    ),
                    isHeart: false);
              }),
        );
      },
    );
  }

  Widget categories(BuildContext context, SearchCubit bloc) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      buildWhen: (previous, current) {
        return current.isEmpty != previous.isEmpty;
      },
      builder: (context, state) => state.isEmpty
          ? SizedBox(
              height: 120,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: bloc.state.categories.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: categoryWidget(context,
                            bloc.state.categories.elementAt(index).name),
                      );
                    }

                    return categoryWidget(
                        context, bloc.state.categories.elementAt(index).name);
                  }),
            )
          : const SizedBox(),
    );
  }

  BlocBuilder<SearchCubit, SearchState> textInImageBackground(
      SearchCubit bloc) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      buildWhen: (previous, current) {
        return previous.isEmpty != current.isEmpty;
      },
      builder: (context, state) {
        return state.isEmpty == true
            ? Column(
                children: [
                  Text('MEGASALE',
                      style: GoogleFonts.shrikhand(
                          fontSize: 30, color: Colors.orange)),
                  Text('BOOK WEEK',
                      style: GoogleFonts.nunito(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.brownColor),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ))),
                      child: const Text('See All'),
                      onPressed: () {})
                ],
              )
            : Container(
                height: 0,
              );
      },
    );
  }

  Row topBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Search',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              GoRouter.of(context).push(Paths.cartScreen);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Icon(
                MaterialCommunityIcons.cart,
                size: 20,
              ),
            ))
      ],
    );
  }

  BlocBuilder<SearchCubit, SearchState> imageBackground(SearchCubit bloc) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      buildWhen: (previous, current) {
        return previous.isEmpty != current.isEmpty;
      },
      builder: (context, state) {
        return state.isEmpty
            ? Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    color: AppColors.greyColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Image.asset(
                      AppAssets.imgPersonBook,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : Container();
      },
    );
  }

  Padding extensionSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('SALE', style: GoogleFonts.nunito(color: AppColors.redColor)),
          const Divider(),
          lineText('NEW IN'),
          lineText('Clothes'),
          lineText('Shoe'),
          lineText('Accessories & Bags'),
          lineText('Beach Wear'),
          lineText('Cosmetics & Personal Care'),
          lineText('BEST DEAL'),
        ],
      ),
    );
  }

  lineText(title) {
    final whiteGrey = AppColors.greyColor.withOpacity(0.2);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title),
        Icon(
          MaterialCommunityIcons.chevron_right,
          color: whiteGrey,
        )
      ]),
      Divider(
        color: whiteGrey,
      ),
    ]);
  }
}
