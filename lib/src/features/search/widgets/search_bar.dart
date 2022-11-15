import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
import '../../../configs/constants/app_colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.textEditingController,
      this.focusNode,
      this.hintText = 'Chú dế mèn phiêu lưu ký'})
      : super(key: key);
  final TextEditingController textEditingController;
  final String hintText;
  final FocusNode? focusNode;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer? _debounce;
  late final SearchCubit bloc;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      print(widget.textEditingController.text);
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

  // var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(focusNode);
    // focusNode.requestFocus();
    return searchBar();
  }

  BlocBuilder<SearchCubit, SearchState> searchBar() {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      // buildWhen: (previous, current) {
      //   return previous.contentSearches != current.contentSearches;
      // },
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              onChanged: (value) {
                // bloc.addNewEvent(SearchEnum.isEmpty,
                //     widget.textEditingController.text.isEmpty);
                _onSearchChanged();
                setState(() {});
              },
              onSubmitted: (value) {
                GoRouter.of(context)
                    .push(Paths.detailSearchScreen, extra: value);
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
                  hintText: widget.hintText,
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
                            // bloc.addNewEvent(SearchEnum.isEmpty, true);
                            setState(() {});
                          },
                          child: Icon(
                            MaterialCommunityIcons.close_circle,
                            color: AppColors.brownColor,
                          ),
                        )),
            ),
          ],
        );
      },
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
