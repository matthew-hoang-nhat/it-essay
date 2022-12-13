part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState({
    required this.fUser,
    required this.itemCartQuantity,
    required this.address,
  });

  final FUserLocalDao? fUser;
  final int itemCartQuantity;
  final Address? address;

  @override
  List<Object?> get props => [fUser, itemCartQuantity, address?.id];
}

class AppInitial extends AppState {
  const AppInitial({
    required super.fUser,
    required super.itemCartQuantity,
    required super.address,
  });
}

class NewAppState extends AppState {
  NewAppState.fromOldSettingState(
    AppState oldState, {
    FUserLocalDao? fUser,
    int? itemCartQuantity,
    Address? address,
  }) : super(
          fUser: fUser ?? oldState.fUser,
          itemCartQuantity: itemCartQuantity ?? oldState.itemCartQuantity,
          address: address ?? oldState.address,
        );
}
