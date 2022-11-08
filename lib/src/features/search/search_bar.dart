import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';
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
                      .map((e) => lineText(e.name))
                      .toList()
                ],
              ),
          ],
        );
      },
    );
  }
}

lineText(text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: GoogleFonts.nunito(fontSize: 16),
      ),
      const Divider(),
    ],
  );
}
