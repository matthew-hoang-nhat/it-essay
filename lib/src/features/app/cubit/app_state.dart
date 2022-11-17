part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState({
    required this.fCartLocal,
    required this.fUserLocal,
  });

  final FCartLocal fCartLocal;
  final FUserLocal fUserLocal;

  @override
  List<Object> get props => [fCartLocal, fUserLocal];
}

class AppInitial extends AppState {
  const AppInitial({
    required super.fCartLocal,
    required super.fUserLocal,
  });
}

class NewAppState extends AppState {
  NewAppState.fromOldSettingState(
    AppState oldState, {
    FCartLocal? fCartLocal,
    FUserLocal? fUserLocal,
  }) : super(
          fCartLocal: fCartLocal ?? oldState.fCartLocal,
          fUserLocal: fUserLocal ?? oldState.fUserLocal,
        );
}
