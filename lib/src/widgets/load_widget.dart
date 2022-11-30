// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';

enum LoadingTypeEnum { fast }

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.loadingType,
  }) : super(key: key);
  final LoadingTypeEnum? loadingType;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0.5),
        constraints: const BoxConstraints.expand(),
        child: Center(child: _getTypeLoading(loadingType)));
  }

  Widget _getTypeLoading(LoadingTypeEnum? type) {
    switch (type) {
      case LoadingTypeEnum.fast:
        return LoadingAnimationWidget.fourRotatingDots(
            color: AppColors.primaryColor, size: 50);
      // case LoadingTypeEnum.splash:
      //   return LoadingAnimationWidget.waveDots(
      //       color: AppColors.primaryColor, size: 50);

      default:
        return LoadingAnimationWidget.waveDots(
            color: AppColors.primaryColor, size: 50);
    }
  }
}
