import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/cubit/main_cubit.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainCubit>();
    return Stack(children: [
      BlocBuilder<MainCubit, MainState>(
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
      ),
      BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              previous.isFirstLoading != current.isFirstLoading,
          bloc: context.read<HomeCubit>(),
          builder: (context, state) {
            if (state.isFirstLoading == false) return Container();
            return Container(
                color: AppColors.whiteColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppAssets.fkImHarryPotter1,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Book World",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.bold)),
                      Text("Everything you need",
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(
                          height: 50,
                          child: LoadingAnimationWidget.waveDots(
                              color: AppColors.primaryColor, size: 50))
                    ],
                  ),
                ));
          })
    ]);
  }
}
