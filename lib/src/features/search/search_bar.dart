import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import '../../configs/constants/app_colors.dart';
import '../../configs/constants/app_dimensions.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.textEditingController})
      : super(key: key);
  final TextEditingController textEditingController;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer? _debounce;
  late final SearchCubit bloc;

  _onSearchChanged() {
    if (bloc.state.isEmpty != widget.textEditingController.text.isEmpty) {
      bloc.addNewEvent(
          SearchEnum.isEmpty, widget.textEditingController.text.isEmpty);
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.textEditingController.text.isNotEmpty) {
        bloc.searchContent(widget.textEditingController.text);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<SearchCubit>();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      buildWhen: (previous, current) {
        return previous.contentSearches != current.contentSearches;
      },
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: widget.textEditingController,
              onChanged: (value) {
                _onSearchChanged();
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(),
                  filled: true, //<-- SEE HERE
                  // fillColor: AppColors.whiteBlueColor, //<
                  fillColor: AppColors.whiteColor, //<

                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(AppDimensions.dp20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(AppDimensions.dp20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(AppDimensions.dp20),
                  ),
                  labelStyle: GoogleFonts.nunito(color: AppColors.brownColor),
                  // labelText: widget.hintText,
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    MaterialCommunityIcons.crosshairs,
                    color: AppColors.greyColor,
                  ),
                  suffixIcon: widget.textEditingController.text.isEmpty
                      ? Icon(
                          MaterialCommunityIcons.arrow_right_circle,
                          color: AppColors.brownColor,
                        )
                      : InkWell(
                          onTap: () {
                            widget.textEditingController.clear();
                            bloc.addNewEvent(SearchEnum.isEmpty, true);
                            setState(() {});
                          },
                          child: Icon(
                            MaterialCommunityIcons.close_circle,
                            color: AppColors.brownColor,
                          ),
                        )),
            ),
            if (widget.textEditingController.text.isNotEmpty)
              Column(
                children: [
                  ...bloc.state.contentSearches
                      .map((e) => resultLineTextSearch(
                          e.name, widget.textEditingController.text, e.slug))
                      .toList()
                ],
              ),
          ],
        );
      },
    );
  }

  resultLineTextSearch(text, query, slug) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            widget.textEditingController.text = text;
            bloc.addNewEvent(
                SearchEnum.contentSearches, List<ContentSearch>.empty());
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
              width: double.infinity,
              child: Text(
                text,
                style: GoogleFonts.nunito(fontSize: 16),
              )
              // RichText(
              //   text: TextSpan(
              //     children: highlightOccurrences(text, query),
              //     style: GoogleFonts.nunito(
              //         color: AppColors.greyColor, fontSize: 16),
              //   ),
              // ),
              ),
        ),
        const Divider(),
      ],
    );
  }

  // List<TextSpan> highlightOccurrences(String source, String query) {
  //   if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
  //     return [TextSpan(text: source)];
  //   }
  //   final matches = query.toLowerCase().allMatches(source.toLowerCase());

  //   int lastMatchEnd = 0;

  //   final List<TextSpan> children = [];
  //   for (var i = 0; i < matches.length; i++) {
  //     final match = matches.elementAt(i);

  //     if (match.start != lastMatchEnd) {
  //       children.add(TextSpan(
  //         text: source.substring(lastMatchEnd, match.start),
  //       ));
  //     }

  //     children.add(TextSpan(
  //       text: source.substring(match.start, match.end),
  //       style:
  //           const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  //     ));

  //     if (i == matches.length - 1 && match.end != source.length) {
  //       children.add(TextSpan(
  //         text: source.substring(match.end, source.length),
  //       ));
  //     }

  //     lastMatchEnd = match.end;
  //   }
  //   return children;
  // }
}
