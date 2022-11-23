part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState({
    required this.fUser,
    required this.itemCartQuantity,
  });

  final FUserLocalDao? fUser;
  final int itemCartQuantity;

  @override
  List<Object?> get props => [fUser, itemCartQuantity];
}

class AppInitial extends AppState {
  const AppInitial({
    required super.fUser,
    required super.itemCartQuantity,
  });
}

class NewAppState extends AppState {
  NewAppState.fromOldSettingState(
    AppState oldState, {
    FUserLocalDao? fUser,
    int? itemCartQuantity,
  }) : super(
          fUser: fUser ?? oldState.fUser,
          itemCartQuantity: itemCartQuantity ?? oldState.itemCartQuantity,
        );
}
