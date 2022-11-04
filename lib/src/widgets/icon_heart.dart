import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../configs/constants/app_colors.dart';

// ignore: must_be_immutable
class IconHeartWidget extends StatefulWidget {
  IconHeartWidget({super.key, required this.isHeart});
  bool isHeart;

  @override
  State<IconHeartWidget> createState() => _IconHeartWidgetState();
}

class _IconHeartWidgetState extends State<IconHeartWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          widget.isHeart = !widget.isHeart;
          setState(() {});
        },
        child: Container(
          height: 35,
          width: 35,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Icon(
            widget.isHeart
                ? MaterialCommunityIcons.heart
                : MaterialCommunityIcons.heart_outline,
            size: 25,
            color: widget.isHeart ? AppColors.redColor : AppColors.brownColor,
          ),
        ));
  }
}
