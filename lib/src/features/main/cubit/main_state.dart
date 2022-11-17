part of 'main_cubit.dart';

abstract class MainState extends Equatable {
  const MainState({
    required this.tab,
    required this.barItems,
    required this.tabs,
  });

  final int tab;
  final List<BottomNavigationBarItem> barItems;
  final List tabs;

  @override
  List<Object?> get props => [
        tab,
        tabs,
        barItems,
      ];
}

class MainInitial extends MainState {
  const MainInitial({
    required super.tab,
    required super.barItems,
    required super.tabs,
  });
}

class NewMainState extends MainState {
  NewMainState.fromOldSettingState(
    MainState oldState, {
    int? tab,
    List<BottomNavigationBarItem>? barItems,
    List? tabs,
  }) : super(
          tab: tab ?? oldState.tab,
          barItems: barItems ?? oldState.barItems,
          tabs: tabs ?? oldState.tabs,
        );
}
