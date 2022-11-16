import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/shopping_cart/cubit/cart_cubit.dart';
import 'package:it_project/src/features/shopping_cart/widgets/item_cart_widget.dart';

class ComponentCartWidget extends StatelessWidget {
  const ComponentCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteColor,
          ),
          child: Column(
              children: bloc.state.itemCarts
                  .map(
                    (e) => ItemCartWidget(
                      product: e,
                    ),
                  )
                  .toList()),
        );
      },
    );
  }
}
