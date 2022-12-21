import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import '../../../configs/constants/app_colors.dart';
import 'package:intl/intl.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return TextField(
            focusNode: context.read<SearchCubit>().focusNode,
            controller: context.read<SearchCubit>().searchController,
            onChanged: (value) {
              context.read<SearchCubit>().onSearchChanged();
            },
            onSubmitted: (value) {
              if (value.isEmpty) return;
              if (GoRouterState.of(context).location ==
                  Paths.detailSearchScreen) {
                context.read<SearchCubit>().loadPageProducts(
                    SearchCubitLoadProductEnum.refreshOnlyProducts);
                return;
              }
              context.read<SearchCubit>().loadPageProducts(
                  SearchCubitLoadProductEnum.refreshOnlyFilter);

              GoRouter.of(context).push(Paths.detailSearchScreen, extra: value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(),
              filled: true,
              fillColor: AppColors.whiteColor,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
              labelStyle: GoogleFonts.nunito(color: AppColors.brownColor),
              // labelText: widget.hintText,
              hintText:
                  'Warren Buffett: 22 thương vụ đầu tiên và bài học đắt giá từ những sai lầm',
              prefixIcon: Icon(
                MaterialCommunityIcons.crosshairs,
                color: AppColors.greyColor,
              ),
              suffixIcon: filterIcon(context),
            ));
      },
    );
  }

  Widget filterIcon(context) => InkWell(
        onTap: () {
          final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * .7,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Bộ lọc tìm kiếm',
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text('Tìm kiếm theo',
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 10,
                            children: [
                              filterTypeSearchChip(
                                  context, SearchTypeEnum.nameProduct),
                              filterTypeSearchChip(
                                  context, SearchTypeEnum.summary),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ));
        },
        child: Container(
          width: 70,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          // color: AppColors.whiteGreyColor,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteGreyColor)),
          child: BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (previous, current) =>
                previous.searchType != current.searchType,
            builder: (context, state) {
              if (state.searchType == SearchTypeEnum.nameProduct) {
                return const Icon(MaterialCommunityIcons.filter);
              }
              return Text(
                state.searchType.toString(),
                style: GoogleFonts.nunito(
                    color: AppColors.brownColor, fontSize: 14),
              );
            },
          ),
        ),
      );

  Widget filterChip(context, Category category) {
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
            if (value == false) {
              if (state.categoryFilter?.id == categoryId) {
                BlocProvider.of<SearchCubit>(context)
                    .setField(SearchCubitEnum.filterCategory, value: null);
              }
            }
          },
        );
      },
    );
  }

  Widget filterTypeSearchChip(context, SearchTypeEnum searchType) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final isSelected = (state.searchType == searchType);
        return FilterChip(
          label: Text(searchType.toString()),
          selected: isSelected,
          selectedColor: AppColors.primaryColor,
          onSelected: (bool value) {
            if (value == true) {
              BlocProvider.of<SearchCubit>(context)
                  .setField(SearchCubitEnum.searchType, value: searchType);
            }
            if (value == false) {
              if (state.searchType == searchType) {
                BlocProvider.of<SearchCubit>(context).setField(
                    SearchCubitEnum.searchType,
                    value: SearchTypeEnum.nameProduct);
              }
            }
          },
        );
      },
    );
  }
}
