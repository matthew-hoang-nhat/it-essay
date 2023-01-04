import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:logger/logger.dart';

import '../../../configs/constants/app_colors.dart';
import 'package:intl/intl.dart';

class SearchBarDetailWidget extends StatelessWidget {
  const SearchBarDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final outLine = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5),
    );
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (contextCubit, state) {
        return TextField(
            // focusNode: context.read<SearchCubit>().focusNode,
            controller: contextCubit.read<SearchCubit>().searchController,
            onSubmitted: (value) {
              if (value.isEmpty) return;

              contextCubit.read<SearchCubit>().setCurrentSearchText();
              Logger().i(GoRouter.of(context).location);
              switch (GoRouter.of(context).location) {
                case '${Paths.sellerScreen}/${Paths.sDetailSearchScreen}':
                  contextCubit.read<SearchCubit>().searchProducts(
                      TypeSearchLoadProductsEnum
                          .newSearchSameFilterWithoutSeller);
                  break;
                case '${Paths.detailCategoryScreen}/${Paths.sDetailSearchScreen}':
                  contextCubit.read<SearchCubit>().searchProducts(
                      TypeSearchLoadProductsEnum
                          .newSearchSameFilterWithoutCategory);
                  break;
                case '${Paths.preSearchScreen}/${Paths.sDetailSearchScreen}':
                  contextCubit.read<SearchCubit>().searchProducts(
                      TypeSearchLoadProductsEnum.newSearchRefreshFilter);
                  break;
                default:
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(),
              filled: true,
              fillColor: AppColors.whiteColor,
              alignLabelWithHint: true,
              border: outLine,
              enabledBorder: outLine,
              focusedBorder: outLine,
              labelStyle: GoogleFonts.nunito(color: AppColors.brownColor),
              hintText:
                  'Warren Buffett: 22 thương vụ đầu tiên và bài học đắt giá từ những sai lầm',
              prefixIcon: Icon(
                MaterialCommunityIcons.crosshairs,
                color: AppColors.greyColor,
              ),
              suffixIcon: const _IconFilterTypeSearchWidget(),
            ));
      },
    );
  }
}

class _IconFilterTypeSearchWidget extends StatelessWidget {
  const _IconFilterTypeSearchWidget();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
        showModalBottomSheet(
            context: context,
            builder: (_) => _filterIconComponentWidget(context));
      },
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        // color: AppColors.whiteGreyColor,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.whiteGreyColor)),
        child: BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) =>
              previous.typeSearch != current.typeSearch,
          builder: (context, state) {
            if (state.typeSearch == TypeSearchEnum.nameProduct) {
              return const Icon(MaterialCommunityIcons.filter);
            }
            return Text(
              state.typeSearch.toString(),
              style:
                  GoogleFonts.nunito(color: AppColors.brownColor, fontSize: 14),
            );
          },
        ),
      ),
    );
  }
}

Widget _filterIconComponentWidget(context) {
  return Container(
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
            style:
                GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text('Tìm kiếm theo',
              style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            children: [
              _filterTypeSearchChip(context, TypeSearchEnum.nameProduct),
              _filterTypeSearchChip(context, TypeSearchEnum.summary),
            ],
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

Widget _filterTypeSearchChip(context, TypeSearchEnum searchType) {
  return BlocBuilder<SearchCubit, SearchState>(
    bloc: BlocProvider.of<SearchCubit>(context),
    builder: (_, state) {
      final isSelected = (state.typeSearch == searchType);
      return FilterChip(
        label: Text(searchType.toString()),
        selected: isSelected,
        selectedColor: AppColors.primaryColor,
        onSelected: (bool value) {
          if (value == true) {
            BlocProvider.of<SearchCubit>(context)
                .setField(SearchCubitEnum.typeSearch, value: searchType);
          }
        },
      );
    },
  );
}
