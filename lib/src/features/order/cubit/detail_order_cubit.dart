import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';

import 'package:it_project/src/utils/repository/order_repository.dart';
import 'package:it_project/src/utils/repository/order_repository_impl.dart';

part 'detail_order_state.dart';

enum DetailOrderEnum { isLoading, orderResponse }

class DetailOrderCubit extends Cubit<DetailOrderState>
    implements ParentCubit<DetailOrderEnum> {
  DetailOrderCubit({required String orderId})
      : super(DetailOrderInitial(
            isLoading: true, orderId: orderId, orderResponse: null));

  OrderRepository orderRepository = getIt<OrderRepositoryImpl>();
  final meLocalKey = viVN;

  initCubit() async {
    _getDetailDetailOrder();
  }

  _getDetailDetailOrder() async {
    addNewEvent(DetailOrderEnum.isLoading, true);
    final result = await orderRepository.getDetailOrder(orderId: state.orderId);
    if (result.isSuccess) {
      addNewEvent(DetailOrderEnum.orderResponse, result.data);
    }
    addNewEvent(DetailOrderEnum.isLoading, false);
  }

  Future<void> cancelAnItemOrder(String itemOrderId) async {
    final result =
        await orderRepository.cancelAnItemOrder(itemOrderId: itemOrderId);
    _getDetailDetailOrder();
  }

  @override
  void addNewEvent(DetailOrderEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case DetailOrderEnum.orderResponse:
        emit(NewDetailOrderState.fromOldSettingState(state,
            orderResponse: value));
        break;

      case DetailOrderEnum.isLoading:
        emit(NewDetailOrderState.fromOldSettingState(state, isLoading: value));
        break;
      default:
    }
  }
}
