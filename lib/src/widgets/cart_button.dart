import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';

InkWell cartButton(BuildContext context) {
  return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        GoRouter.of(context).push(Paths.cartScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Icon(
          MaterialCommunityIcons.cart,
          color: AppColors.whiteColor,
          size: 20,
        ),
      ));
}
