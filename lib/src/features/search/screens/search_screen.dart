import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/features/search/widgets/search_bar.dart';
import 'package:it_project/src/widgets/cart_button.dart';
import 'package:it_project/src/widgets/category_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchCubit>();
    final textEditingController = TextEditingController();
    var focusNode = FocusNode();
    focusNode.requestFocus();

    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
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
                  child: resultBar(bloc, textEditingController),
                ),
                // imageBackground(bloc),
                // textInImageBackground(bloc),
                const SizedBox(height: 20),
                // categories(context, bloc),
                // extensionSearchField(),
                // showProducts(bloc)
                // const ComponentSearchProductVertical()
              ]))),
    );
  }

  BlocBuilder<SearchCubit, SearchState> resultBar(
      bloc, TextEditingController textEditingController) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.isEmpty == true) return Container();
        return Column(
          children: [
            ...bloc.state.contentSearches
                .map((e) => resultLineTextSearch(
                    e.name, textEditingController, bloc, context))
                .toList()
          ],
        );
      },
    );
  }

  resultLineTextSearch(String text, TextEditingController textController,
      SearchCubit bloc, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            textController.text = text;
            // bloc.addNewEvent(
            //     SearchEnum.contentSearches, List<ContentSearch>.empty());
            // FocusScope.of(context).unfocus();
            GoRouter.of(context).push(Paths.detailSearchScreen, extra: text);
            // bloc.loadPageProducts(text);
            // bloc.addNewEvent(SearchEnum.isShowProducts, true);
          },
          child: SizedBox(
              width: double.infinity,
              child: Text(
                text,
                style: GoogleFonts.nunito(fontSize: 16),
              )),
        ),
        const Divider(),
      ],
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
                    final category = bloc.state.categories.elementAt(index);
                    if (index == 0) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CategoryWidget(
                            category: category,
                          ));
                    }
                    return CategoryWidget(category: category);
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
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SALE CỰC KHỦNG',
                            style: GoogleFonts.montserrat(
                                fontSize: 30,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                        Text('Tuần lễ sách',
                            style: GoogleFonts.nunito(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
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

  BlocBuilder<SearchCubit, SearchState> imageBackground(SearchCubit bloc) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      builder: (context, state) {
        return state.isEmpty
            ? Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 300,
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
