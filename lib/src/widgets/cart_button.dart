import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          // GoRouter.of(context).push(Paths.cartScreen);
        },
        child: Stack(alignment: Alignment.topRight, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Icon(
              MaterialCommunityIcons.cart,
              color: AppColors.whiteColor,
              size: 25,
            ),
          ),
          // BlocBuilder<CartCubit, CartState>(
          //     bloc: context.read<CartCubit>(),
          //     builder: (context, state) {
          //       return Container(
          //           width: 20,
          //           height: 20,
          //           margin: const EdgeInsets.only(right: 10, top: 10),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(100),
          //               color: AppColors.whiteColor),
          //           alignment: Alignment.center,
          //           child: Text(
          //            fCartLocal
          //                 .itemCarts
          //                 .length
          //                 .toString(),
          //             style: GoogleFonts.nunito(
          //                 fontSize: 16, color: AppColors.primaryColor),
          //           ));
          //     })
        ]));
  }
}

// InkWell cartButton(BuildContext context) {
//   return InkWell(
//       borderRadius: BorderRadius.circular(100),
//       onTap: () {
//         GoRouter.of(context).push(Paths.cartScreen);
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Icon(
//           MaterialCommunityIcons.cart,
//           color: AppColors.whiteColor,
//           size: 20,
//         ),
//       ));
// }
