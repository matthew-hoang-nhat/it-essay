part of 'history_order_cubit.dart';

abstract class HistoryOrderState extends Equatable {
  const HistoryOrderState(
      {required this.orders,
      required this.isEmpty,
      required this.isLoading,
      required this.loadMoreTab,
      required this.orderStatusTab});

  final List<dynamic> orders;
  final bool isEmpty;
  final bool isLoading;
  final HistoryOrderTabEnum orderStatusTab;
  final HistoryOrderTabEnum loadMoreTab;

  @override
  List<Object> get props => [
        orders,
        isEmpty,
        isLoading,
        orderStatusTab,
        loadMoreTab,
      ];
}

class HistoryOrderInitial extends HistoryOrderState {
  const HistoryOrderInitial({
    required super.isEmpty,
    required super.orderStatusTab,
    required super.loadMoreTab,
    required super.orders,
    required super.isLoading,
  });
}

class NewHistoryOrderState extends HistoryOrderState {
  NewHistoryOrderState.fromOldSettingState(
    HistoryOrderState oldState, {
    List<dynamic>? orders,
    bool? isEmpty,
    bool? isLoading,
    HistoryOrderTabEnum? orderStatusTab,
    HistoryOrderTabEnum? loadMoreTab,
  }) : super(
          orders: orders ?? oldState.orders,
          orderStatusTab: orderStatusTab ?? oldState.orderStatusTab,
          loadMoreTab: loadMoreTab ?? oldState.loadMoreTab,
          isLoading: isLoading ?? oldState.isLoading,
          isEmpty: isEmpty ?? oldState.isEmpty,
        );
}
