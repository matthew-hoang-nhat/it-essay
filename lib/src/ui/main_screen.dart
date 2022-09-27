import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_project/src/ui/main_viewmodel.dart';
import 'package:it_project/src/utils/app_assets.dart';
import 'package:it_project/src/utils/app_colors.dart';

class MainScreen extends GetView<MainViewModel> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
              bottom: true, child: controller.tabs.elementAt(controller.tab)),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.icHomePage,
                  width: 25,
                ),
                activeIcon: Image.asset(
                  AppAssets.icHomePageFilled,
                  width: 25,
                  color: AppColors.blueColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.icOpenBook,
                  width: 25,
                ),
                activeIcon: Image.asset(
                  AppAssets.icOpenBookFilled,
                  width: 25,
                  color: AppColors.blueColor,
                ),
                label: 'My books',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.icCart,
                  width: 25,
                ),
                activeIcon: Image.asset(
                  AppAssets.icCartFilled,
                  width: 25,
                  color: AppColors.blueColor,
                ),
                label: 'Store',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.icHeart,
                  width: 25,
                ),
                activeIcon: Image.asset(
                  AppAssets.icHeartFilled,
                  width: 25,
                  color: AppColors.blueColor,
                ),
                label: 'Favorite',
              ),
            ],
            currentIndex: controller.tab, //New
            onTap: ((value) => controller.tab = value),
          ),
        ));
  }
}
