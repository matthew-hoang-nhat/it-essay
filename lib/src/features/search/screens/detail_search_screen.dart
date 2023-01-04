import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/features/search/widgets/component_search_product_vertical.dart';
import 'package:it_project/src/features/search/widgets/search_bar_detail_widget.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/widgets/cart_button.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
enum DetailSearchExtraEnum { searchText, sellerId, category }

class DetailSearchScreen extends StatelessWidget {
  const DetailSearchScreen({super.key, this.extra});
  final Map<DetailSearchExtraEnum, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..initCubit(extra: extra),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const SearchBarDetailWidget(),
          actions: const [CartButton()],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _productsComponentWidget(),
              _loadingScreenWidget(),
              _darkScreenWidget(),
              const _FilterComponentWidget(),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  Widget _productsComponentWidget() {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.isLoadingMore != current.isLoadingMore,
      builder: (context, state) {
        return SingleChildScrollView(
          controller: context.read<SearchCubit>().scrollController,
          child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ComponentSearchProductVertical(
                    products: state.products,
                  ),
                  if (state.isLoadingMore)
                    Container(
                        child: LoadingAnimationWidget.waveDots(
                            color: AppColors.primaryColor, size: 50))
                ],
              )),
        );
      },
    );
  }

  Widget _loadingScreenWidget() {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingWidget(
            loadingType: LoadingTypeEnum.fast,
          );
        }
        return Container();
      },
    );
  }

  BlocBuilder<SearchCubit, SearchState> _darkScreenWidget() {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          previous.onTypeFilter != current.onTypeFilter,
      builder: (context, state) {
        if (state.onTypeFilter == null) {
          return const SizedBox(
            width: 0,
            height: 0,
          );
        }
        return InkWell(
          onTap: () {
            context
                .read<SearchCubit>()
                .setField(SearchCubitEnum.onTypeFilter, value: null);
          },
          child: Container(
              color: Colors.black.withOpacity(0.3),
              constraints: const BoxConstraints.expand(),
              child: const Center()),
        );
      },
    );
  }
}

class _FilterComponentWidget extends StatelessWidget {
  const _FilterComponentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tabFilterWidget(),
        Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            padding: const EdgeInsets.only(left: 20, right: 20),
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(child: _dropDownFilterWidget()))
      ],
    );
  }

  Widget _tabFilterWidget() {
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
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.onTypeFilter != current.onTypeFilter ||
                      previous.valueTypeFilters[
                              TypeSearchFilterEnum.sellerId] !=
                          current
                              .valueTypeFilters[TypeSearchFilterEnum.sellerId],
                  builder: (context, state) {
                    if (state
                            .valuesTypeFilters[TypeSearchFilterEnum.sellerId] ==
                        null) return Container();
                    bool isOnSellerIdTab =
                        state.onTypeFilter == TypeSearchFilterEnum.sellerId;
                    final sellerId =
                        state.valueTypeFilters[TypeSearchFilterEnum.sellerId]
                            as String?;

                    String titleSellerIdTab = 'Tìm kiếm toàn Bitini ';
                    if (sellerId != null) {
                      titleSellerIdTab = 'Tìm kiếm trong shop này';
                    }
                    final forceColor = (sellerId == null
                        ? AppColors.brownColor
                        : AppColors.whiteColor);
                    final backgroundColor = sellerId == null
                        ? AppColors.whiteGreyColor
                        : AppColors.primaryColor;

                    return InkWell(
                        onTap: () {
                          context.read<SearchCubit>().setField(
                              SearchCubitEnum.onTypeFilter,
                              value: TypeSearchFilterEnum.sellerId);
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(color: backgroundColor),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(titleSellerIdTab,
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(color: forceColor)),
                              if (isOnSellerIdTab)
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
                        ));
                  },
                ),
                const SizedBox(width: 20),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.onTypeFilter != current.onTypeFilter ||
                      previous.valueTypeFilters[
                              TypeSearchFilterEnum.category] !=
                          current
                              .valueTypeFilters[TypeSearchFilterEnum.category],
                  builder: (context, state) {
                    bool isOnCategoryTab =
                        state.onTypeFilter == TypeSearchFilterEnum.category;
                    final category =
                        state.valueTypeFilters[TypeSearchFilterEnum.category]
                            as Category?;

                    String titleCategory = 'Theo danh mục';
                    if (category != null) {
                      titleCategory = category.name;
                    }
                    final forceColor = (category == null
                        ? AppColors.brownColor
                        : AppColors.whiteColor);
                    final backgroundColor = category == null
                        ? AppColors.whiteGreyColor
                        : AppColors.primaryColor;

                    return InkWell(
                        onTap: () {
                          context.read<SearchCubit>().setField(
                              SearchCubitEnum.onTypeFilter,
                              value: TypeSearchFilterEnum.category);
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(color: backgroundColor),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(titleCategory,
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(color: forceColor)),
                              if (isOnCategoryTab)
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
                        ));
                  },
                ),
                const SizedBox(width: 20),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.onTypeFilter != current.onTypeFilter ||
                      previous.valueTypeFilters[TypeSearchFilterEnum.price] !=
                          current.valueTypeFilters[TypeSearchFilterEnum.price],
                  builder: (context, state) {
                    bool isOnCategoryTab =
                        state.onTypeFilter == TypeSearchFilterEnum.price;
                    final minPrice =
                        state.valueTypeFilters[TypeSearchFilterEnum.price] ?? 0;
                    final minPriceStr = formatCurrency.format(minPrice);
                    final forceColor = (minPrice == 0
                        ? AppColors.brownColor
                        : AppColors.whiteColor);
                    final backgroundColor = minPrice == 0
                        ? AppColors.whiteGreyColor
                        : AppColors.primaryColor;
                    return InkWell(
                      onTap: () {
                        context.read<SearchCubit>().setField(
                            SearchCubitEnum.onTypeFilter,
                            value: TypeSearchFilterEnum.price);
                      },
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: backgroundColor),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(minPrice == 0 ? 'Giá' : 'Giá từ $minPriceStr',
                                style: GoogleFonts.nunito(color: forceColor)),
                            if (isOnCategoryTab)
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
                ),
              ],
            ),
          ),
        ),
        Container(height: 2, color: AppColors.whiteGreyColor),
      ],
    );
  }

  Widget _dropDownFilterWidget() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) =>
              previous.onTypeFilter != current.onTypeFilter ||
              previous.valuesTypeFilters != current.valuesTypeFilters ||
              previous.valueTypeFilters[TypeSearchFilterEnum.category] !=
                  current.valueTypeFilters[TypeSearchFilterEnum.category],
          builder: (context, state) {
            final categories =
                state.valuesTypeFilters[TypeSearchFilterEnum.category] as List?;
            if (state.onTypeFilter != TypeSearchFilterEnum.category ||
                categories == null) {
              return Container();
            }
            return Wrap(
                spacing: 10,
                children: categories
                    .map((category) => categoryFilterChip(category))
                    .toList());
          },
        ),
        BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) =>
              previous.onTypeFilter != current.onTypeFilter ||
              previous.valuesTypeFilters != current.valuesTypeFilters ||
              previous.valueTypeFilters[TypeSearchFilterEnum.price] !=
                  current.valueTypeFilters[TypeSearchFilterEnum.price],
          builder: (context, state) {
            if (state.onTypeFilter != TypeSearchFilterEnum.price) {
              return Container();
            }
            final minPrice =
                state.valueTypeFilters[TypeSearchFilterEnum.price] ?? 0.0;
            final minPriceStr = formatCurrency.format(minPrice);
            return Column(
              children: [
                Slider(
                  min: 0,
                  max: 500000,
                  divisions: 10,
                  value: minPrice,
                  label: minPriceStr,
                  onChanged: (value) {
                    context
                        .read<SearchCubit>()
                        .setField(SearchCubitEnum.minPrice, value: value);
                  },
                  onChangeEnd: (value) {
                    context.read<SearchCubit>().searchProducts(
                        TypeSearchLoadProductsEnum.newSearchSameFilter);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Giá từ '),
                    Text(minPriceStr),
                  ],
                ),
              ],
            );
          },
        ),
        BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) =>
              previous.onTypeFilter != current.onTypeFilter ||
              previous.valuesTypeFilters != current.valuesTypeFilters ||
              previous.valueTypeFilters[TypeSearchFilterEnum.sellerId] !=
                  current.valueTypeFilters[TypeSearchFilterEnum.sellerId],
          builder: (context, state) {
            final sellerValues =
                state.valuesTypeFilters[TypeSearchFilterEnum.sellerId] as List?;
            if (state.onTypeFilter != TypeSearchFilterEnum.sellerId ||
                sellerValues == null) {
              return Container();
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sellerValues
                    .map((sellerId) => sellerFilterChip(sellerId))
                    .toList());
          },
        ),
      ],
    );
  }

  Widget sellerFilterChip(String? sellerId) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          previous.valuesTypeFilters[TypeSearchFilterEnum.sellerId] !=
          current.valuesTypeFilters[TypeSearchFilterEnum.sellerId],
      builder: (context, state) {
        final name = (sellerId == null)
            ? 'Tìm kiếm toàn Bitini'
            : 'Tìm kiếm trong shop này';
        final isSelected =
            state.valueTypeFilters[TypeSearchFilterEnum.sellerId] == sellerId;
        return FilterChip(
          label: Text(name),
          selected: isSelected,
          selectedColor: AppColors.primaryColor,
          onSelected: (bool value) {
            if (value == true) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.filterSellerId, value: sellerId);
            }

            final stateSellerId =
                state.valueTypeFilters[TypeSearchFilterEnum.sellerId];

            if (value == false && stateSellerId == sellerId) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.filterCategory, value: null);
            }

            context.read<SearchCubit>()
              ..searchProducts(TypeSearchLoadProductsEnum.newSearchSameFilter)
              ..setField(SearchCubitEnum.onTypeFilter,
                  value: TypeSearchFilterEnum.sellerId);
          },
        );
      },
    );
  }

  Widget categoryFilterChip(Category category) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          previous.typeFilters != current.typeFilters,
      builder: (context, state) {
        final name = category.name;
        final isSelected =
            (state.valueTypeFilters[TypeSearchFilterEnum.category] as Category?)
                    ?.id ==
                category.id;
        return FilterChip(
          label: Text(name),
          selected: isSelected,
          selectedColor: AppColors.primaryColor,
          onSelected: (bool value) {
            if (value == true) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.filterCategory, value: category);
            }

            final stateCategory = state
                .valueTypeFilters[TypeSearchFilterEnum.category] as Category?;

            if (value == false && stateCategory?.id == category.id) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.filterCategory, value: null);
            }

            context.read<SearchCubit>()
              ..searchProducts(TypeSearchLoadProductsEnum.newSearchSameFilter)
              ..setField(SearchCubitEnum.onTypeFilter,
                  value: TypeSearchFilterEnum.category);
          },
        );
      },
    );
  }
}
