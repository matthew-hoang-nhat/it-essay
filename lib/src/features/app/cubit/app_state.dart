part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {
  const AppInitial();
}

class NewAppState extends AppState {
  const NewAppState.fromOldSettingState(
    AppState oldState,
  ) : super();
}
