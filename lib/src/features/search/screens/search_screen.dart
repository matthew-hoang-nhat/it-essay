import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/features/search/widgets/search_bar.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/widgets/cart_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchCubit>(context)
        .loadPageProducts(SearchCubitLoadProductEnum.refresh);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          title: const SearchBar(),
          actions: const [CartButton()],
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: resultBar(context),
              ),
              const SizedBox(height: 20),
            ])));
  }

  BlocBuilder<SearchCubit, SearchState> resultBar(context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          previous.contentSearches != current.contentSearches,
      builder: (context, state) {
        return Column(
          children: [
            ...state.contentSearches
                .map((e) => resultLineTextSearch(e, context))
                .toList()
          ],
        );
      },
    );
  }

  resultLineTextSearch(ContentSearch contentSearch, context) {
    final ContentTypeEnum? type = contentSearchType[contentSearch.type];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            BlocProvider.of<SearchCubit>(context).setField(
                SearchCubitEnum.searchText,
                value: contentSearch.name);

            switch (type) {
              case ContentTypeEnum.product:
                GoRouter.of(context)
                    .push(Paths.detailSearchScreen, extra: contentSearch.name);
                break;
              case ContentTypeEnum.category:
                GoRouter.of(context).push(Paths.detailCategoryScreen,
                    extra: Category(
                        name: contentSearch.name,
                        slug: contentSearch.slug,
                        id: contentSearch.id));
                break;
              default:
            }
          },
          child: SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: contentSearchType[contentSearch.type] ==
                          ContentTypeEnum.category
                      ? const Icon(
                          MaterialCommunityIcons.card_text,
                          size: 20,
                        )
                      : const Icon(
                          MaterialCommunityIcons.book,
                          size: 20,
                        ),
                ),
                Expanded(
                  child: Text(
                    contentSearch.name,
                    maxLines: 2,
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
