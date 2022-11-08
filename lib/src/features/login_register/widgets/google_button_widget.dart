import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../configs/constants/app_colors.dart';

class GoogleButtonWidget extends StatefulWidget {
  const GoogleButtonWidget({super.key});

  @override
  State<GoogleButtonWidget> createState() => _GoogleButtonWidgetState();
}

class _GoogleButtonWidgetState extends State<GoogleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      borderRadius: BorderRadius.circular(100),
      onTap: () async {
        // Get.toNamed(AppPages.mainScreen);
        GoogleSignIn googleSignIn = GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],
        );
        try {
          await googleSignIn.signIn();
        } catch (error) {
          print(error);
        }
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.greyColor.withOpacity(0.5)),
        child: const Icon(
          MaterialCommunityIcons.google,
          size: 30,
        ),
      ),
    );
  }
}
