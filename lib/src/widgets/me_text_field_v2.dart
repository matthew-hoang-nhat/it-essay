import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';

class MeTextFieldV2 extends StatefulWidget {
  const MeTextFieldV2(
      {Key? key,
      this.hintText,
      this.isPassword = false,
      required this.textEditingController,
      required this.announcement,
      this.isCheckEmpty = false,
      this.text,
      this.isEnabled = true,
      required this.onChanged})
      : super(key: key);
  final String? hintText;
  final bool isPassword;
  final String? text;
  final bool? isEnabled;
  final TextEditingController textEditingController;
  final bool isCheckEmpty;
  final String? announcement;
  final Function() onChanged;

  @override
  State<MeTextFieldV2> createState() => _MeTextFieldV2State();
}

class _MeTextFieldV2State extends State<MeTextFieldV2> {
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
          onChanged: (value) {
            widget.onChanged();
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: GoogleFonts.nunito(color: AppColors.brownColor),
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
        ),
        if (widget.isCheckEmpty == true &&
            widget.textEditingController.text.isEmpty)
          Text(
            meLocalKey[MeLocaleKey.emptyFill] ?? 'err: Empty Fill',
            style: GoogleFonts.nunito(
              color: AppColors.redColor,
            ),
          )
        else if (widget.announcement != null)
          Text(
            widget.announcement!,
            style: GoogleFonts.nunito(
              color: AppColors.redColor,
            ),
          )
      ],
    );
  }
}
