import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class MeBottomModal {
  static void showMeModalBottomSheet(context,
      {required String title, required Widget widget, Widget? bottom}) {
    var scrollButton = Container(
      height: 7,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.whiteColor),
    );
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FractionallySizedBox(
              heightFactor: 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  scrollButton,
                  const SizedBox(
                    height: 7,
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Expanded(child: widget)
                          ],
                        )),
                  ),
                  if (bottom != null) bottom,
                ],
              ),
            ),
          );
        });
  }
}
