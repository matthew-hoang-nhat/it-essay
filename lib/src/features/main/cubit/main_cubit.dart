import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/f_user_local.dart';
import 'package:it_project/src/features/main/home/home_screen.dart';
import 'package:it_project/src/features/main/notification/screens/notification_tab_screen.dart';
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
        icon: Icon(MaterialCommunityIcons.home_outline, size: 20.0),
        activeIcon: Icon(MaterialCommunityIcons.home, size: 20.0),
        label: 'Home',
      ),
      // const BottomNavigationBarItem(
      //     icon: Icon(MaterialCommunityIcons.heart_outline, size: 20.0),
      //     activeIcon: Icon(MaterialCommunityIcons.heart, size: 20.0),
      //     label: 'Wishlist'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.bell_ring_outline, size: 20.0),
          activeIcon: Icon(MaterialCommunityIcons.bell_ring, size: 20.0),
          label: 'Notification'),
      const BottomNavigationBarItem(
          activeIcon: Icon(MaterialCommunityIcons.contacts, size: 20.0),
          icon: Icon(MaterialCommunityIcons.contacts_outline, size: 20.0),
          label: 'Profile'),
    ];
    emit(state.copyWith(barItems: newBarItems));

    final newTabs = [
      const HomeScreen(),
      isLogin == true ? const NotificationTabScreen() : const LoginPopup(),
      isLogin == true ? const ProfileScreen() : const LoginPopup()
    ];

    emit(state.copyWith(
      tabs: newTabs,
      tab: 0,
    ));
  }
}
