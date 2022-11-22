import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:it_project/src/features/shopping_cart/cubit/cart_cubit.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/widgets/icon_heart.dart';

import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_dimensions.dart';

class ItemCartWidget extends StatelessWidget {
  const ItemCartWidget({super.key, required this.product});
  final ItemCart product;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    bool isSaleOffProduct = product.discountPercent > 0;
    final bloc = context.read<CartCubit>();

    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.dp5),
                  child:
                      // Image.asset(
                      //   AppAssets.fkImHarryPotter1,
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      // ),
                      CachedNetworkImage(
                    imageUrl: product.productImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.dp20),
                      ),
                      Text(
                        product.sellerName,
                        style: GoogleFonts.nunito(
                          color: AppColors.brownColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      greyTextAndBlackText('Mã sản phẩm:', product.slug),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            formatCurrency.format(product.price *
                                (100 - product.discountPercent) /
                                100),
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.dp20,
                              color:
                                  isSaleOffProduct ? AppColors.redColor : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (isSaleOffProduct)
                            Text(
                              formatCurrency.format(product.price),
                              style: GoogleFonts.nunito(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                                color: AppColors.greyColor,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              bloc.actionCart(CartActionEnum.dec,
                                  productSlug: product.slug);

                              if (product.quantity == 1) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: RichText(
                                          text: TextSpan(
                                              style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  color: AppColors.brownColor),
                                              children: [
                                            const TextSpan(
                                                text:
                                                    'Bạn có muốn xóa sản phẩm '),
                                            TextSpan(
                                                text: '${product.name} ',
                                                style: GoogleFonts.nunito(
                                                    color: AppColors.redColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: 'ra khỏi giỏ hàng?',
                                                style: GoogleFonts.nunito()),
                                          ])),
                                      actions: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColors.redColor),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ))),
                                          onPressed: () {
                                            bloc.actionCart(
                                                CartActionEnum.removeItem,
                                                productSlug: product.slug);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Có'),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColors.blueColor),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Không'),
                                        ),
                                      ],
                                      actionsAlignment: MainAxisAlignment.end),
                                );
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.whiteGreyColor),
                                child:
                                    const Icon(MaterialCommunityIcons.minus)),
                          ),
                          Container(
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(product.quantity.toString())),
                          InkWell(
                            onTap: () {
                              bloc.actionCart(CartActionEnum.inc,
                                  productSlug: product.slug);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.whiteGreyColor),
                                child: const Icon(MaterialCommunityIcons.plus)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
            IconHeartWidget(
              isHeart: false,
            )
          ],
        ),
        const Divider()
      ],
    );
  }

  Widget greyTextAndBlackText(String text, String amount) {
    return Wrap(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            color: AppColors.greyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          amount,
          style: GoogleFonts.nunito(
            color: AppColors.brownColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
