import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../configs/constants/app_colors.dart';
import 'main_viewmodel.dart';

class MainScreen extends GetView<MainViewModel> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barItems = [
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.home), label: 'a'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.crosshairs), label: 'a'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.heart), label: 'a'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.account), label: 'a'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.dots_grid), label: 'a'),
    ];

    return Obx(() => Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true, // very important as noted
          body: controller.tabs
              .elementAt(controller.tab > 3 ? 0 : controller.tab),
          // bottomNavigationBar: SnakeNavigationBar.color(
          //   behaviour: SnakeBarBehaviour.floating,
          //   snakeShape: SnakeShape.circle,
          //   // backgroundColor: AppColors,
          //   snakeViewColor: AppColors.brownColor,
          //   selectedItemColor: AppColors.whiteColor,
          //   // shape: bottomBarShape,
          //   backgroundColor: Colors.white.withOpacity(0.2),
          //   // elevation: 0,
          //   items: barItems,
          //   currentIndex: controller.tab,
          //   onTap: ((value) => controller.tab = value),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            // behaviour: SnakeBarBehaviour.floating,
            // snakeShape: SnakeShape.circle,
            // // backgroundColor: AppColors,
            // snakeViewColor: AppColors.brownColor,

            selectedItemColor: AppColors.blueColor,
            unselectedItemColor: AppColors.blueColor,
            // shape: bottomBarShape,
            backgroundColor: Colors.red.withOpacity(0.3),
            type: BottomNavigationBarType.fixed,

            elevation: 0,
            items: barItems,
            currentIndex: controller.tab,
            onTap: ((value) => controller.tab = value),
          ),
        ));
  }
}
