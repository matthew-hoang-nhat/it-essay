import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/home/home_screen.dart';
import 'package:it_project/src/features/profile/screens/profile_screen.dart';
import 'package:it_project/src/utils/app_shared.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tab = 0;
  final List tabs = [
    // const HomeScreen(),i
    const HomeScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
    // const SearchScreen(),
    // const MyBookScreen(),
    // const MeScreen(),
    // const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    const sizeIcon = 20.0;
    final isLogin = getIt<AppShared>().getTokenValue() != null;

    final barItems = [
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.home, size: sizeIcon),
          label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.heart, size: sizeIcon),
          label: 'Wishlist'),
      BottomNavigationBarItem(
          icon: isLogin
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      height: sizeIcon + 5,
                      width: sizeIcon + 5,
                      color: AppColors.blueColor,
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          AppAssets.fkImHarryPotter1,
                          height: sizeIcon + 5,
                          width: sizeIcon + 5,
                          fit: BoxFit.cover,
                        ),
                      )))
              : const Icon(MaterialCommunityIcons.contacts, size: sizeIcon),
          label: 'Profile'),
      // const BottomNavigationBarItem(
      //     icon: Icon(MaterialCommunityIcons.dots_grid), label: 'Setting'),
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true, // very important as noted
      body: tabs.elementAt(tab),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.brownColor,

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
