import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.textEditingController})
      : super(key: key);
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(),
          filled: true, //<-- SEE HERE
          fillColor: AppColors.whiteBlueColor, //<
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
          hintText: 'Search',
          prefixIcon: const Icon(
            Icons.search,
          )),
    );
  }
}
