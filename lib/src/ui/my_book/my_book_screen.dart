import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/ui/my_book/my_book_viewmodel.dart';
import 'package:it_project/src/ui/widgets/big_post.dart';
import 'package:it_project/src/ui/widgets/state_post.dart';
import 'package:it_project/src/utils/app_colors.dart';
import 'package:it_project/src/utils/app_dimensions.dart';

class MyBookScreen extends GetView<MyBookViewModel> {
  const MyBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            continueReading(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                BigPost(
                  backgroundColor: AppColors.whiteColor,
                ),
                const SizedBox(
                  height: AppDimensions.dp20,
                ),
                BigPost(
                  backgroundColor: AppColors.whiteColor,
                ),
                const SizedBox(
                  height: AppDimensions.dp20,
                ),
                BigPost(
                  backgroundColor: AppColors.whiteColor,
                ),
                const SizedBox(
                  height: AppDimensions.dp20,
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }

  Column continueReading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Continue reading (3)',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold, fontSize: AppDimensions.dp20)),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(children: const [
            SizedBox(
              width: 20,
            ),
            StatePost(),
            SizedBox(
              width: 20,
            ),
            StatePost(),
            SizedBox(
              width: 20,
            ),
            StatePost(),
            SizedBox(
              width: 20,
            ),
            StatePost(),
            SizedBox(
              width: 20,
            ),
          ]),
        ),
      ],
    );
  }
}
