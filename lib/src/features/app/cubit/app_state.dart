part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState({
    required this.fUser,
  });

  final FUserLocalDao fUser;

  @override
  List<Object> get props => [fUser];
}

class AppInitial extends AppState {
  const AppInitial({required super.fUser});
}

class NewAppState extends AppState {
  NewAppState.fromOldSettingState(
    AppState oldState, {
    FUserLocalDao? fUser,
  }) : super(
          fUser: fUser ?? oldState.fUser,
        );
}
