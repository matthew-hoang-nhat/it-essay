import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      onChanged: (value) {
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
                    setState(() {});
                  },
                  child: Icon(
                    MaterialCommunityIcons.close_circle,
                    color: AppColors.brownColor,
                  ),
                )),
    );
  }
}
