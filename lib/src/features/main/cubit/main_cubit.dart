import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/main/home/home_screen.dart';
import 'package:it_project/src/features/profile/screens/profile_screen.dart';
import 'package:it_project/src/widgets/login_popup_widget.dart';

part 'main_state.dart';

enum MainEnum {
  tab,
  barItems,
  tabs,
}

class MainCubit extends Cubit<MainState> implements ParentCubit<MainEnum> {
  MainCubit()
      : super(const MainInitial(tab: 0, barItems: [], tabs: [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ]));

  bool get isLogin => getIt<FUserLocal>().isLogged;

  reloadMainScreen() {
    addNewEvent(MainEnum.barItems, [
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.home, size: 20.0), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.heart, size: 20.0),
          label: 'Wishlist'),
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
                                )
                          // Image.asset(
                          //   AppAssets.fkImHarryPotter1,
                          //   height: 20.0 + 5,
                          //   width: 20.0 + 5,
                          //   fit: BoxFit.cover,
                          // ),
                          )))
              : const Icon(MaterialCommunityIcons.contacts, size: 20.0),
          label: 'Profile'),
    ]);
    addNewEvent(MainEnum.tabs, [
      const HomeScreen(),
      isLogin == true ? const ProfileScreen() : const LoginPopup(),
      isLogin == true ? const ProfileScreen() : const LoginPopup()
    ]);
    addNewEvent(MainEnum.tab, 0);
  }

  @override
  void addNewEvent(MainEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case MainEnum.tab:
        emit(NewMainState.fromOldSettingState(state, tab: value));
        break;
      case MainEnum.tabs:
        emit(NewMainState.fromOldSettingState(state, tabs: value));
        break;
      case MainEnum.barItems:
        emit(NewMainState.fromOldSettingState(state, barItems: value));
        break;
      default:
    }
  }
}
