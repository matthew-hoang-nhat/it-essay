import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/order/cubit/history_order_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/inline_history_order_response_widget.dart';
import '../widgets/inline_item_order_widget.dart';

class HistoryOrderScreen extends StatelessWidget {
  const HistoryOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryOrderCubit, HistoryOrderState>(
      bloc: context.read<HistoryOrderCubit>()..initCubit(),
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lịch sử mua hàng'),
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    BlocBuilder<HistoryOrderCubit, HistoryOrderState>(
                      buildWhen: (previous, current) =>
                          previous.orderStatusTab != current.orderStatusTab,
                      builder: (context, state) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: HistoryOrderTabEnum.values
                                  .sublist(
                                      0, HistoryOrderTabEnum.values.length - 1)
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: ChoiceChip(
                                        label: Text(e.toString()),
                                        selected: state.orderStatusTab == e,
                                        selectedColor: AppColors.primaryColor,
                                        onSelected: (value) {
                                          context
                                              .read<HistoryOrderCubit>()
                                              .changeTab(e);
                                        },
                                      ),
                                    ),
                                  )
                                  .toList()),
                        );
                      },
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          BlocBuilder<HistoryOrderCubit, HistoryOrderState>(
                              buildWhen: (previous, current) =>
                                  previous.orders != current.orders,
                              builder: (context, state) {
                                return ListView(
                                  controller: context
                                      .read<HistoryOrderCubit>()
                                      .controller,
                                  scrollDirection: Axis.vertical,
                                  children: state.orders
                                      .map((e) => InkWell(
                                            onTap: () {
                                              final String extra = e
                                                      is OrderResponse
                                                  ? e.id
                                                  : (e as ItemOrder).orderId!;
                                              context.push(
                                                  Paths.detailOrderScreen,
                                                  extra: extra);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20,
                                                  left: 20,
                                                  right: 20),
                                              child: Column(
                                                children: [
                                                  e is OrderResponse
                                                      ? InlineHistoryOrder(
                                                          orderResponse: e,
                                                        )
                                                      : InlineItemOrderWidget(
                                                          productOrder: e,
                                                          isInDetailOrder:
                                                              false,
                                                        ),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                );
                              }),
                          BlocBuilder<HistoryOrderCubit, HistoryOrderState>(
                            buildWhen: (previous, current) =>
                                previous.loadMoreTab != current.loadMoreTab ||
                                previous.orderStatusTab !=
                                    current.orderStatusTab,
                            builder: (context, state) {
                              if (state.orderStatusTab == state.loadMoreTab) {
                                return Container(
                                  height: 20,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: LoadingAnimationWidget.waveDots(
                                      color: AppColors.primaryColor, size: 50),
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<HistoryOrderCubit, HistoryOrderState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading,
                builder: (context, state) {
                  if (state.isLoading) return const LoadingWidget();
                  return Container();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
