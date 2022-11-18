import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class MeEditTextField extends StatefulWidget {
  const MeEditTextField({
    super.key,
    required this.textEditingController,
    // required this.typeEdit,
    required this.func,
  });
  final TextEditingController textEditingController;
  // final EditFieldProfileEnum typeEdit;
  final String? Function(String value) func;
  @override
  State<MeEditTextField> createState() => _MeEditTextFieldState();
}

class _MeEditTextFieldState extends State<MeEditTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.whiteColor,
          child: TextField(
            controller: widget.textEditingController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              widget.func(value);
              setState(() {});
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.func(widget.textEditingController.text) ?? '',
            style: GoogleFonts.nunito(
              color: AppColors.redColor,
            ),
          ),
        ),
      ],
    );
  }
}
