import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/cubit/main_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainCubit>();
    return BlocBuilder<MainCubit, MainState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: state.tabs.elementAt(state.tab),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.brownColor,
            items: state.barItems,
            currentIndex: state.tab,
            onTap: ((value) {
              bloc.addNewEvent(MainEnum.tab, value);
            }),
          ),
        );
      },
    );
  }
}
