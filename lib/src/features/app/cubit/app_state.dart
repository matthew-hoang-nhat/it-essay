part of 'app_cubit.dart';

class AppState extends Equatable {
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

  AppState copyWith({
    FUserLocalDao? fUser,
    int? itemCartQuantity,
    Address? address,
  }) {
    return AppState(
      fUser: fUser ?? this.fUser,
      itemCartQuantity: itemCartQuantity ?? this.itemCartQuantity,
      address: address ?? this.address,
    );
  }
}

class AppInitial extends AppState {
  const AppInitial({
    required super.fUser,
    required super.itemCartQuantity,
    required super.address,
  });
}
