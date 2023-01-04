import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/pre_search_cubit.dart';
import 'package:it_project/src/features/search/screens/detail_search_screen.dart';
import 'package:it_project/src/features/search/widgets/search_bar_pre_widget.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';

import 'package:it_project/src/widgets/cart_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreSearchCubit(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            foregroundColor: AppColors.whiteColor,
            backgroundColor: AppColors.primaryColor,
            title: const SearchBarPreWidget(),
            actions: const [CartButton()],
          ),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: resultBar(),
                ),
                const SizedBox(height: 20),
              ]))),
    );
  }

  Widget resultBar() {
    return BlocBuilder<PreSearchCubit, PreSearchState>(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.push(
                '${Paths.preSearchScreen}/${Paths.sDetailSearchScreen}',
                extra: {
                  DetailSearchExtraEnum.searchText: contentSearch.name,
                });
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
