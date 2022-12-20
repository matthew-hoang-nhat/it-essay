// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_cubit.dart';

class MainState extends Equatable {
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

  MainState copyWith({
    int? tab,
    List<BottomNavigationBarItem>? barItems,
    List? tabs,
  }) {
    return MainState(
      tab: tab ?? this.tab,
      barItems: barItems ?? this.barItems,
      tabs: tabs ?? this.tabs,
    );
  }
}

class MainInitial extends MainState {
  const MainInitial({
    required super.tab,
    required super.barItems,
    required super.tabs,
  });
}
