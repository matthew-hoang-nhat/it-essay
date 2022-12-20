import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';
import 'package:it_project/src/utils/repository/order_repository.dart';
import 'package:it_project/src/utils/repository/order_repository_impl.dart';
import 'package:logger/logger.dart';

part 'history_order_state.dart';

enum OrderEnum {
  ordered,
  packed,
  shipped,
  delivered;

  @override
  String toString() {
    switch (this) {
      case OrderEnum.ordered:
        return 'Chờ xác nhận';

      case OrderEnum.delivered:
        return 'Chờ lấy hàng';

      case OrderEnum.packed:
        return 'Đang giao';

      case OrderEnum.shipped:
        return 'Đã giao';

      default:
        return 'Không tìm thấy';
    }
  }

  static OrderEnum toEnum(String statusOder) {
    switch (statusOder) {
      case 'ordered':
        return OrderEnum.ordered;
      case 'packed':
        return OrderEnum.packed;
      case 'shipped':
        return OrderEnum.shipped;
      case 'delivered':
        return OrderEnum.delivered;
      default:
        Logger().e('Not match String and OrderEnum');
        return OrderEnum.ordered;
    }
  }
}

// enum HistoryOrderCubitEnum {
//   isEmpty,
//   isLoading,
//   orderStatusTab,
//   orders,
//   loadMoreTab
// }

enum HistoryOrderTabEnum {
  orders,
  ordered,
  packed,
  shipping,
  completed,
  cancel,
  nothing;

  @override
  String toString() {
    switch (this) {
      case HistoryOrderTabEnum.orders:
        return 'Tất cả';
      case HistoryOrderTabEnum.ordered:
        return 'Chờ xác nhận';
      case HistoryOrderTabEnum.packed:
        return 'Chờ lấy hàng';
      case HistoryOrderTabEnum.shipping:
        return 'Đang giao';
      case HistoryOrderTabEnum.completed:
        return 'Đã giao';
      case HistoryOrderTabEnum.cancel:
        return 'Đã hủy';
      case HistoryOrderTabEnum.nothing:
        return 'Không có gì';
    }
  }
}

class HistoryOrderCubit extends Cubit<HistoryOrderState> {
  HistoryOrderCubit()
      : super(const HistoryOrderInitial(
          orders: [],
          isEmpty: false,
          isLoading: false,
          loadMoreTab: HistoryOrderTabEnum.nothing,
          orderStatusTab: HistoryOrderTabEnum.orders,
        ));
  final OrderRepository _orderRepository = getIt<OrderRepositoryImpl>();

  int _currentPageOrders = 1;
  int _currentPageOrdered = 1;
  int _currentPagePacked = 1;
  int _currentPageShipping = 1;
  int _currentPageCompleted = 1;
  int _currentPageCancelOrders = 1;

  List<OrderResponse> allOrders = [];
  List<ItemOrder> allOrdered = [];
  List<ItemOrder> allPackedOrders = [];
  List<ItemOrder> allShippingOrders = [];
  List<ItemOrder> allCompletedOrders = [];
  List<ItemOrder> allCancelOrders = [];

  resetData() {
    allOrders = [];
    allOrdered = [];
    allPackedOrders = [];
    allShippingOrders = [];
    allCompletedOrders = [];
    allCancelOrders = [];

    _currentPageCancelOrders = 1;
    _currentPageCompleted = 1;
    _currentPageOrdered = 1;
    _currentPageOrders = 1;
    _currentPagePacked = 1;
    _currentPageShipping = 1;

    controller = ScrollController();
  }

  ScrollController controller = ScrollController();

  addListenerLoadMore() {
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent * 0.7) {
        if (state.loadMoreTab != HistoryOrderTabEnum.nothing) return;
        loadMore(state.orderStatusTab);
      }
    });
  }

  initCubit() async {
    resetData();
    addListenerLoadMore();
    emit(const HistoryOrderInitial(
      orders: [],
      isEmpty: false,
      isLoading: true,
      loadMoreTab: HistoryOrderTabEnum.nothing,
      orderStatusTab: HistoryOrderTabEnum.orders,
    ));

    await Future.wait([
      _getAllOrders(),
      _getAllOrdered(),
      _getAllShippingOrders(),
      _getAllPackedOrders(),
      _getAllCompletedOrders(),
      _getAllCancelOrders()
    ]);

    emit(state.copyWith(
      orders: [...allOrders],
      isLoading: false,
    ));
  }

  refreshTab(HistoryOrderTabEnum tab) async {
    List newOrders = [];
    switch (tab) {
      case HistoryOrderTabEnum.ordered:
        _currentPageOrdered = 1;
        allOrdered = [];
        await _getAllOrdered();
        newOrders = [...allOrdered];
        break;
      case HistoryOrderTabEnum.cancel:
        _currentPageCancelOrders = 1;
        allCancelOrders = [];
        await _getAllCancelOrders();
        newOrders = [...allCancelOrders];
        break;
      default:
    }
    if (tab == state.orderStatusTab) {
      emit(state.copyWith(orders: [...newOrders]));
    }
  }

  loadMore(HistoryOrderTabEnum loadMoreTab) async {
    List newOrders = [];
    emit(state.copyWith(loadMoreTab: loadMoreTab));
    switch (loadMoreTab) {
      case HistoryOrderTabEnum.orders:
        await _loadMoreAllOrders();
        newOrders = [...allOrders];
        break;
      case HistoryOrderTabEnum.ordered:
        await _loadMoreAllOrdered();
        newOrders = [...allOrdered];
        break;
      case HistoryOrderTabEnum.packed:
        await _loadMoreAllPacked();
        newOrders = [...allPackedOrders];
        break;
      case HistoryOrderTabEnum.shipping:
        await _loadMoreAllShipping();
        newOrders = [...allShippingOrders];
        break;
      case HistoryOrderTabEnum.completed:
        await _loadMoreAllCompleted();
        newOrders = [...allCompletedOrders];
        break;
      case HistoryOrderTabEnum.cancel:
        await _loadMoreAllCancelOrders();
        newOrders = [...allCancelOrders];
        break;
      default:
    }

    final currentTab = state.orderStatusTab;
    if (loadMoreTab == currentTab) {
      emit(state.copyWith(orders: [...newOrders]));
    }

    emit(state.copyWith(loadMoreTab: HistoryOrderTabEnum.nothing));
  }

  bool isLoadingOrders = false;
  _loadMoreAllOrders() async {
    if (isLoadingOrders) return;
    _currentPageOrders++;
    await _getAllOrders();
    // addNewEvent(HistoryOrderCubitEnum.orders, [...allOrders]);
  }

  Future<void> _getAllOrders() async {
    isLoadingOrders = true;
    final ordersResponse =
        await _orderRepository.getAllOrder(currentPage: _currentPageOrders);

    if (ordersResponse.isSuccess && ordersResponse.data!.isNotEmpty) {
      allOrders.addAll(ordersResponse.data!);
    }
    if (ordersResponse.isError || ordersResponse.data!.isEmpty) {
      _currentPageOrders--;
    }

    isLoadingOrders = false;
  }

  bool isLoadingCancelOrders = false;
  _loadMoreAllCancelOrders() async {
    if (isLoadingCancelOrders) return;
    _currentPageCancelOrders++;
    await _getAllCancelOrders();
    // addNewEvent(HistoryOrderCubitEnum.orders, [...allOrders]);
  }

  Future<void> _getAllCancelOrders() async {
    isLoadingCancelOrders = true;
    final ordersResponse = await _orderRepository.getAllCancelOrders(
        currentPage: _currentPageCancelOrders);
    if (ordersResponse.isSuccess && ordersResponse.data!.isNotEmpty) {
      allCancelOrders.addAll(ordersResponse.data!);
    }
    if (ordersResponse.isError || ordersResponse.data!.isEmpty) {
      _currentPageCancelOrders--;
    }
    isLoadingCancelOrders = false;
  }

  bool isLoadingOrdered = false;
  _loadMoreAllOrdered() async {
    if (isLoadingOrdered) return;
    _currentPageOrdered++;
    await _getAllOrdered();
  }

  Future<void> _getAllOrdered() async {
    isLoadingOrdered = true;
    final ordersResponse =
        await _orderRepository.getAllOrdered(currentPage: _currentPageOrdered);
    if (ordersResponse.isSuccess && ordersResponse.data!.isNotEmpty) {
      allOrdered.addAll(ordersResponse.data!);
    }
    if (ordersResponse.isError || ordersResponse.data!.isEmpty) {
      _currentPageOrdered--;
    }
    isLoadingOrdered = false;
  }

  bool isLoadingShipping = false;
  _loadMoreAllShipping() async {
    if (isLoadingShipping) return;
    _currentPageShipping++;
    await _getAllShippingOrders();
  }

  _loadMoreAllPacked() async {
    if (isLoadingPacked) return;
    _currentPagePacked++;
    await _getAllPackedOrders();
  }

  _loadMoreAllCompleted() async {
    if (isLoadingCompleted) return;
    _currentPageCompleted++;
    await _getAllCompletedOrders();
  }

  void changeTab(HistoryOrderTabEnum tab) async {
    final oldTab = state.orderStatusTab;
    emit(state.copyWith(orderStatusTab: tab));

    switch (tab) {
      case HistoryOrderTabEnum.orders:
        emit(state.copyWith(orders: [...allOrders]));

        break;
      case HistoryOrderTabEnum.ordered:
        emit(state.copyWith(orders: [...allOrdered]));

        break;
      case HistoryOrderTabEnum.packed:
        emit(state.copyWith(orders: [...allPackedOrders]));

        break;
      case HistoryOrderTabEnum.shipping:
        emit(state.copyWith(orders: [...allShippingOrders]));

        break;
      case HistoryOrderTabEnum.completed:
        emit(state.copyWith(orders: [...allCompletedOrders]));

        break;
      case HistoryOrderTabEnum.cancel:
        emit(state.copyWith(orders: [...allCancelOrders]));

        break;
      default:
        emit(state.copyWith(orders: []));
    }

    if (oldTab == tab) {
      controller.animateTo(0,
          curve: Curves.easeIn, duration: const Duration(seconds: 1));
    } else {
      controller.jumpTo(0);
    }
  }

  bool isLoadingPacked = false;
  Future<void> _getAllPackedOrders() async {
    isLoadingPacked = true;
    final ordersResponse =
        await _orderRepository.getAllPacked(currentPage: _currentPagePacked);
    if (ordersResponse.isSuccess) {
      allPackedOrders.addAll(ordersResponse.data!);
    }
    if (ordersResponse.isError) {
      _currentPagePacked--;
    }
    isLoadingPacked = false;
  }

  bool isLoadingCompleted = false;
  Future<void> _getAllCompletedOrders() async {
    isLoadingCompleted = true;
    final ordersResponse = await _orderRepository.getAllCompletedOrders(
        currentPage: _currentPageCompleted);
    if (ordersResponse.isSuccess) {
      allCompletedOrders.addAll(ordersResponse.data!);
    }
    if (ordersResponse.isError) {
      _currentPageCompleted--;
    }
    isLoadingCompleted = false;
  }

  Future<void> _getAllShippingOrders() async {
    isLoadingShipping = true;
    final ordersResponse = await _orderRepository.getAllShippingOrders(
        currentPage: _currentPageShipping);
    if (ordersResponse.isSuccess) {
      allShippingOrders.addAll(ordersResponse.data!);
    }
    if (ordersResponse.isError) {
      _currentPageShipping--;
    }
    isLoadingShipping = false;
  }
}
