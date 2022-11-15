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

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SearchCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();

    var focusNode = FocusNode();
    focusNode.requestFocus();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          title: SearchBar(
            focusNode: focusNode,
            textEditingController: textEditingController,
            hintText: 'Chú dế mèn kêu',
          ),
          actions: [cartButton(context)],
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: resultBar(context, textEditingController),
              ),
              // imageBackground(bloc),
              // textInImageBackground(bloc),
              const SizedBox(height: 20),
              // categories(context, bloc),
              // extensionSearchField(),
              // showProducts(bloc)
              // const ComponentSearchProductVertical()
            ])));
  }

  BlocBuilder<SearchCubit, SearchState> resultBar(
      context, TextEditingController textEditingController) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.contentSearches != current.contentSearches,
      builder: (context, state) {
        print('rebuild resultbar');
        return Column(
          children: [
            ...state.contentSearches
                .map((e) =>
                    resultLineTextSearch(e, textEditingController, context))
                .toList()
          ],
        );
      },
    );
  }

  resultLineTextSearch(ContentSearch contentSearch,
      TextEditingController textController, context) {
    final ContentTypeEnum? type = contentSearchType[contentSearch.type];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            textController.text = contentSearch.name;
            // bloc.addNewEvent(
            //     SearchEnum.contentSearches, List<ContentSearch>.empty());
            // FocusScope.of(context).unfocus();
            switch (type) {
              case ContentTypeEnum.product:
                GoRouter.of(context)
                    .push(Paths.detailSearchScreen, extra: contentSearch.name);
                break;
              case ContentTypeEnum.category:
                GoRouter.of(context).push(Paths.detailCategoryScreen,
                    extra: Category(
                        name: contentSearch.name, slug: contentSearch.slug));
                break;
              default:
            }

            // GoRouter.of(context).push(Paths.detailSearchScreen, extra: text);
            // bloc.loadPageProducts(text);
            // bloc.addNewEvent(SearchEnum.isShowProducts, true);
          },
          child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: contentSearchType[contentSearch.type] ==
                              ContentTypeEnum.category
                          ? const Icon(MaterialCommunityIcons.card_text)
                          : null),
                  Text(
                    contentSearch.name,
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                ],
              )),
        ),
        const Divider(),
      ],
    );
  }

  // Widget categories(BuildContext context, SearchCubit bloc) {
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
