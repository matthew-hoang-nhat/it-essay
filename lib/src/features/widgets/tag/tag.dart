import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(),
      ),
    );
  }
}
