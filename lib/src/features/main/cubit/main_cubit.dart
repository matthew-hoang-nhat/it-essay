import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/main/home/home_screen.dart';
import 'package:it_project/src/features/profile/screens/profile_screen.dart';
import 'package:it_project/src/widgets/login_popup_widget.dart';

part 'main_state.dart';

enum MainEnum {
  tab,
  barItems,
  tabs,
}

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(const MainInitial(tab: 0, barItems: [], tabs: [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ]));

  bool get isLogin => getIt<FUserLocal>().isLogged;

  setTab(int value) {
    emit(state.copyWith(tab: value));
  }

  reloadMainScreen() {
    final newBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.home, size: 20.0), label: 'Home'),
      // const BottomNavigationBarItem(
      //     icon: Icon(MaterialCommunityIcons.heart, size: 20.0),
      //     label: 'Wishlist'),
      BottomNavigationBarItem(
          icon: isLogin
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      height: 20.0 + 5,
                      width: 20.0 + 5,
                      color: AppColors.blueColor,
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: getIt<FUserLocal>().fUser!.avatar == null
                              ? Container()
                              : CachedNetworkImage(
                                  imageUrl: getIt<FUserLocal>().fUser!.avatar!,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: AppColors.primaryColor,
                                  ),
                                  width: 20 + 5,
                                  height: 20 + 5,
                                  fit: BoxFit.cover,
                                ))))
              : const Icon(MaterialCommunityIcons.contacts, size: 20.0),
          label: 'Profile'),
    ];
    emit(state.copyWith(barItems: newBarItems));

    final newTabs = [
      const HomeScreen(),
      // isLogin == true ? const ProfileScreen() : const LoginPopup(),
      isLogin == true ? const ProfileScreen() : const LoginPopup()
    ];
    emit(state.copyWith(
      tabs: newTabs,
      tab: 0,
    ));
  }
}
