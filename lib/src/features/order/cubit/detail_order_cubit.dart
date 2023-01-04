import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';

import 'package:it_project/src/utils/repository/order_repository.dart';
import 'package:it_project/src/utils/repository/order_repository_impl.dart';

part 'detail_order_state.dart';

class DetailOrderCubit extends Cubit<DetailOrderState> {
  DetailOrderCubit({required String orderId})
      : super(DetailOrderInitial(
            isLoading: true, orderId: orderId, orderResponse: null));

  OrderRepository orderRepository = getIt<OrderRepositoryImpl>();
  final meLocalKey = viVN;

  initCubit() async {
    _getDetailDetailOrder();
  }

  _getDetailDetailOrder() async {
    emit(state.copyWith(isLoading: true));

    final result = await orderRepository.getDetailOrder(orderId: state.orderId);
    if (result.isSuccess) {
      final orderResponse = result.data;
      emit(state.copyWith(orderResponse: orderResponse));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> cancelAnItemOrder(String itemOrderId) async {
    final result =
        await orderRepository.cancelAnItemOrder(itemOrderId: itemOrderId);
    _getDetailDetailOrder();
  }
}
