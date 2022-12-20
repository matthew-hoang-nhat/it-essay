// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_order_cubit.dart';

class DetailOrderState extends Equatable {
  const DetailOrderState({
    required this.orderResponse,
    required this.orderId,
    required this.isLoading,
  });

  final OrderResponse? orderResponse;
  final String orderId;
  final bool isLoading;

  @override
  List<Object?> get props => [
        orderResponse,
        isLoading,
      ];

  DetailOrderState copyWith({
    OrderResponse? orderResponse,
    String? orderId,
    bool? isLoading,
  }) {
    return DetailOrderState(
      orderResponse: orderResponse ?? this.orderResponse,
      orderId: orderId ?? this.orderId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DetailOrderInitial extends DetailOrderState {
  const DetailOrderInitial({
    required super.orderResponse,
    required super.orderId,
    required super.isLoading,
  });
}
