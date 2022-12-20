// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_order_cubit.dart';

class HistoryOrderState extends Equatable {
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

  HistoryOrderState copyWith({
    List<dynamic>? orders,
    bool? isEmpty,
    bool? isLoading,
    HistoryOrderTabEnum? orderStatusTab,
    HistoryOrderTabEnum? loadMoreTab,
  }) {
    return HistoryOrderState(
      orders: orders ?? this.orders,
      isEmpty: isEmpty ?? this.isEmpty,
      isLoading: isLoading ?? this.isLoading,
      orderStatusTab: orderStatusTab ?? this.orderStatusTab,
      loadMoreTab: loadMoreTab ?? this.loadMoreTab,
    );
  }
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
