part of 'detail_order_cubit.dart';

abstract class DetailOrderState extends Equatable {
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
}

class DetailOrderInitial extends DetailOrderState {
  const DetailOrderInitial({
    required super.orderResponse,
    required super.orderId,
    required super.isLoading,
  });
}

class NewDetailOrderState extends DetailOrderState {
  NewDetailOrderState.fromOldSettingState(
    DetailOrderState oldState, {
    OrderResponse? orderResponse,
    String? orderId,
    bool? isLoading,
  }) : super(
          orderResponse: orderResponse ?? oldState.orderResponse,
          isLoading: isLoading ?? oldState.isLoading,
          orderId: orderId ?? oldState.orderId,
        );
}
