import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/src/features/login_register/cubit/login_cubit.dart';

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
      onTap: () {
        context.read<LoginCubit>().googleLoginClick();
      },
      //  () async {
      //   try {
      //     const serverClientId =
      //         '177322333542-5s78k6m5htmshg70qiprq450413qafts.apps.googleusercontent.com';
      //     final GoogleSignInAccount? googleUser =
      //         await GoogleSignIn(serverClientId: serverClientId, scopes: [
      //       'https://www.googleapis.com/auth/userinfo.profile',
      //       'https://www.googleapis.com/auth/userinfo.email'
      //     ]).signIn();

      //     final GoogleSignInAuthentication? googleAuth =
      //         await googleUser?.authentication;

      //     if (googleAuth != null) {}
      //     Logger().i(googleAuth?.idToken);
      //     Logger().i(googleAuth?.accessToken);

      //     final credential = GoogleAuthProvider.credential(
      //       accessToken: googleAuth?.accessToken,
      //       idToken: googleAuth?.idToken,
      //     );

      //     // Backend trả về thông tin như Login bằng tài khoản bình thường cho FE

      //   } catch (ex) {
      //     Logger().e(ex);
      //   }
      //   // Logger().i(getGoogleOAuthURL);
      // },

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

  // getGoogleOAuthURL() {
  //   const rootUrl = "https://accounts.google.com/o/oauth2/v2/auth";

  //   final options = {
  //     'redirect_uri': "https://main-server-v1.onrender.com/v1/api/oauth/google",
  //     'client_id':
  //         "177322333542-5s78k6m5htmshg70qiprq450413qafts.apps.googleusercontent.com",
  //     'access_type': "online",
  //     'response_type': 'code',
  //     'prompt': "consent",
  //     'scope': [
  //       'https://www.googleapis.com/auth/userinfo.profile',
  //       'https://www.googleapis.com/auth/userinfo.email'
  //     ].join(" "),
  //   };

  //   final qs = UrlSearchParams(options);
  //   return '$rootUrl?${qs.toString()}';
  // }
}
