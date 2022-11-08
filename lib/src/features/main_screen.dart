import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/home_product/home_screen.dart';
import 'package:it_project/src/features/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tab = 1;
  final List tabs = [
    // const HomeScreen(),i
    const HomeScreen(),
    const SearchScreen(),
    // const MyBookScreen(),
    // const MeScreen(),
    // const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final barItems = [
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.crosshairs), label: 'Search'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.heart), label: 'Wishlist'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.account), label: 'Profile'),
      // const BottomNavigationBarItem(
      //     icon: Icon(MaterialCommunityIcons.dots_grid), label: 'Setting'),
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true, // very important as noted
      body: tabs.elementAt(tab > 1 ? 0 : tab),
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
      // currentIndex: controller.tab,
      // onTap: ((value) => controller.tab = value),
      // ),

      bottomNavigationBar: BottomNavigationBar(
        // behaviour: SnakeBarBehaviour.floating,
        // snakeShape: SnakeShape.circle,
        // // backgroundColor: AppColors,
        // snakeViewColor: AppColors.brownColor
        //
        type: BottomNavigationBarType.fixed,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        selectedItemColor: AppColors.blueColor,
        unselectedItemColor: AppColors.brownColor,
        // shape: bottomBarShape,
        // backgroundColor: Colors.red.withOpacity(0.3),

        // elevation: 0,
        items: barItems,
        currentIndex: tab,
        onTap: ((value) {
          tab = value;
          setState(() {});
        }),
      ),
    );
  }
}
