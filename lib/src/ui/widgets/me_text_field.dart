import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/utils/app_colors.dart';
import 'package:it_project/src/utils/app_dimensions.dart';

class MeTextField extends StatefulWidget {
  const MeTextField({
    Key? key,
    this.hintText,
    this.isPassword = false,
    required this.textEditingController,
  }) : super(key: key);
  final String? hintText;
  final bool isPassword;
  final TextEditingController textEditingController;

  @override
  State<MeTextField> createState() => _MeTextFieldState();
}

class _MeTextFieldState extends State<MeTextField> {
  late bool isHide;
  @override
  void initState() {
    super.initState();
    settingVariable();
  }

  settingVariable() {
    isHide = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: isHide,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.brownColor,
            width: AppDimensions.dp2,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.dp20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppDimensions.dp2,
            color: AppColors.brownColor,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.dp20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppDimensions.dp2,
            color: AppColors.brownColor,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.dp20),
        ),
        labelStyle: GoogleFonts.nunito(color: AppColors.brownColor),
        // labelText: widget.hintText,
        hintText: widget.hintText,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  isHide = !isHide;
                  setState(() {});
                },
                icon: isHide == true
                    ? Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.brownColor,
                      )
                    : const Icon(Icons.remove_red_eye))
            : null,
      ),
    );
  }
}
