import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/features/search/widgets/component_search_product_vertical.dart';
import 'package:it_project/src/features/search/widgets/search_bar.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/widgets/cart_button.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailSearchScreen extends StatelessWidget {
  const DetailSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<SearchCubit>()
        .loadPageProducts(SearchCubitLoadProductEnum.refreshOnlyProducts);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const SearchBar(),
        // actions: [cartButton(context)],
        actions: const [CartButton()],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: context.read<SearchCubit>().scrollController,
              child: const Padding(
                padding: EdgeInsets.only(top: 70),
                child: ComponentSearchProductVertical(),
              ),
            ),
            BlocBuilder<SearchCubit, SearchState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingWidget(
                    loadingType: LoadingTypeEnum.fast,
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              buildWhen: (previous, current) =>
                  previous.typeFilter != current.typeFilter,
              builder: (context, state) {
                if (state.typeFilter == SearchTypeFilterEnum.nothing) {
                  return const SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
                return InkWell(
                  onTap: () {
                    context.read<SearchCubit>().setField(
                        SearchCubitEnum.typeFilter,
                        value: SearchTypeFilterEnum.nothing);
                  },
                  child: Container(
                      color: Colors.black.withOpacity(0.3),
                      constraints: const BoxConstraints.expand(),
                      child: const Center()),
                );
              },
            ),
            tabFilterWidget(context),
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(
                    10,
                  )),
              child: BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (previous, current) =>
                    previous.typeFilter != current.typeFilter,
                builder: (context, state) {
                  if (state.typeFilter == SearchTypeFilterEnum.nothing) {
                    return const SizedBox(
                      width: 0,
                      height: 0,
                    );
                  }
                  return SingleChildScrollView(
                      child: dropDownFilterWidget(context));
                },
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }

  Widget tabFilterWidget(context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: AppColors.whiteColor,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    BlocProvider.of<SearchCubit>(context).setField(
                        SearchCubitEnum.typeFilter,
                        value: SearchTypeFilterEnum.category);
                  },
                  child: BlocBuilder<SearchCubit, SearchState>(
                    buildWhen: (previous, current) =>
                        previous.categoryFilter != current.categoryFilter ||
                        previous.typeFilter != current.typeFilter,
                    builder: (context, state) {
                      String titleCategory = 'Theo danh mục';
                      if (state.categoryFilter != null) {
                        titleCategory = state.categoryFilter!.name;
                      }
                      final forceColor = (state.categoryFilter == null
                          ? AppColors.brownColor
                          : AppColors.whiteColor);
                      final backgroundColor = state.categoryFilter == null
                          ? AppColors.whiteGreyColor
                          : AppColors.primaryColor;
                      return Container(
                        height: 30,
                        // width: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: backgroundColor),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(titleCategory,
                                maxLines: 1,
                                style: GoogleFonts.nunito(color: forceColor)),
                            if (state.typeFilter ==
                                SearchTypeFilterEnum.category)
                              Icon(
                                MaterialCommunityIcons.chevron_up,
                                color: forceColor,
                              )
                            else
                              Icon(
                                MaterialCommunityIcons.chevron_down,
                                color: forceColor,
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.minPrice != current.minPrice ||
                      previous.typeFilter != current.typeFilter,
                  builder: (context, state) {
                    final minPrice = formatCurrency.format(state.minPrice);
                    final forceColor = (state.minPrice == 0
                        ? AppColors.brownColor
                        : AppColors.whiteColor);
                    final backgroundColor = state.minPrice == 0
                        ? AppColors.whiteGreyColor
                        : AppColors.primaryColor;
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<SearchCubit>(context).setField(
                            SearchCubitEnum.typeFilter,
                            value: SearchTypeFilterEnum.price);
                      },
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: backgroundColor),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                                state.minPrice == 0
                                    ? 'Giá'
                                    : 'Giá từ $minPrice',
                                style: GoogleFonts.nunito(color: forceColor)),
                            if (state.typeFilter == SearchTypeFilterEnum.price)
                              Icon(
                                MaterialCommunityIcons.chevron_up,
                                color: forceColor,
                              )
                            else
                              Icon(
                                MaterialCommunityIcons.chevron_down,
                                color: forceColor,
                              )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Container(height: 5, color: AppColors.whiteGreyColor),
      ],
    );
  }

  Widget dropDownFilterWidget(context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            BlocBuilder<SearchCubit, SearchState>(
              buildWhen: (previous, current) =>
                  previous.typeFilter != current.typeFilter,
              builder: (context, state) {
                if (state.typeFilter != SearchTypeFilterEnum.category) {
                  return Container();
                }
                return BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return Wrap(
                        spacing: 10,
                        children: state.categories
                            .map((category) =>
                                categoryFilterChip(context, category))
                            .toList());
                  },
                );
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              buildWhen: (previous, current) =>
                  previous.minPrice != current.minPrice ||
                  previous.typeFilter != current.typeFilter,
              builder: (context, state) {
                if (state.typeFilter != SearchTypeFilterEnum.price) {
                  return Container();
                }
                final price = formatCurrency.format(state.minPrice);
                return Column(
                  children: [
                    Slider(
                      min: 0,
                      max: 500000,
                      divisions: 10,
                      value: state.minPrice,
                      label: price,
                      onChanged: (value) {
                        context
                            .read<SearchCubit>()
                            .setField(SearchCubitEnum.minPrice, value: value);
                      },
                      onChangeEnd: (value) {
                        BlocProvider.of<SearchCubit>(context).loadPageProducts(
                            SearchCubitLoadProductEnum.refreshOnlyProducts);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Giá từ '),
                        Text(price),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        )
      ],
    );
  }

  Widget categoryFilterChip(context, Category category) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          previous.categoryFilter != current.categoryFilter,
      builder: (context, state) {
        final name = category.name;
        final categoryId = category.id;
        final isSelected =
            BlocProvider.of<SearchCubit>(context).state.categoryFilter?.id ==
                categoryId;
        return FilterChip(
          label: Text(name),
          selected: isSelected,
          selectedColor: AppColors.primaryColor,
          onSelected: (bool value) {
            if (value == true) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.filterCategory, value: category);
            }
            if (value == false && state.categoryFilter?.id == categoryId) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.filterCategory, value: null);
            }

            context.read<SearchCubit>()
              ..loadPageProducts(SearchCubitLoadProductEnum.refreshOnlyProducts)
              ..setField(SearchCubitEnum.typeFilter,
                  value: SearchTypeFilterEnum.category);
          },
        );
      },
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
