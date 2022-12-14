import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';

class MeTextField extends StatefulWidget {
  const MeTextField(
      {Key? key,
      this.hintText,
      this.isPassword = false,
      required this.textEditingController,
      required this.functionValidation,
      this.isCheckEmpty = false,
      this.text,
      this.callFuncOnChange,
      this.isEnabled = true})
      : super(key: key);
  final String? hintText;
  final bool isPassword;
  final Function()? callFuncOnChange;
  final String? text;
  final bool? isEnabled;
  final TextEditingController textEditingController;
  final bool isCheckEmpty;
  final String? Function(String) functionValidation;

  @override
  State<MeTextField> createState() => _MeTextFieldState();
}

class _MeTextFieldState extends State<MeTextField> {
  late bool isHide;
  final meLocalKey = viVN;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text != null)
          Text(
            '${widget.text!} *',
            style: GoogleFonts.nunito(
              // fontWeight: FontWeight.bold,
              color: AppColors.greyColor,
            ),
          ),
        TextField(
          controller: widget.textEditingController,
          obscureText: isHide,
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: AppColors.brownColor,
            //     width: AppDimensions.dp2,
            //   ),
            //   borderRadius: BorderRadius.circular(AppDimensions.dp20),
            // ),

            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     width: AppDimensions.dp2,
            //     color: AppColors.brownColor,
            //   ),
            //   borderRadius: BorderRadius.circular(AppDimensions.dp20),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     width: AppDimensions.dp2,
            //     color: AppColors.brownColor,
            //   ),
            //   borderRadius: BorderRadius.circular(AppDimensions.dp20),
            // ),
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
          onChanged: (value) {
            if (widget.callFuncOnChange != null) {
              widget.callFuncOnChange!();
            }
            setState(() {});
          },
        ),
        if (widget.isCheckEmpty == true &&
            widget.textEditingController.text.isEmpty)
          Text(
            meLocalKey[MeLocaleKey.emptyFill] ?? 'err: Empty Fill',
            style: GoogleFonts.nunito(
              color: AppColors.redColor,
            ),
          )
        else if (widget.functionValidation(widget.textEditingController.text) !=
            null)
          Text(
            widget.functionValidation(widget.textEditingController.text) ?? '',
            style: GoogleFonts.nunito(
              color: AppColors.redColor,
            ),
          )
      ],
    );
  }
}
