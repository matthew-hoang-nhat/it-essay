import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'product_state.dart';

enum ProductCartActionEnum {
  addItem,
}

class ProductCubit extends Cubit<ProductState> with ActionCart {
  ProductCubit({required Product product})
      : super(ProductInitial(
          isTop: true,
          product: product,
          indexImage: 0,
          isDescribeShowAll: false,
          isLoading: false,
        ));

  final controller = ScrollController();
  final pageController = PageController();

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  final meLocalKey = viVN;

  initCubit() async {
    _getDetailProduct();
    _settingController();
  }

  setShowAll() {
    emit(state.copyWith(isDescribeShowAll: true));
  }

  _getDetailProduct() async {
    emit(state.copyWith(isLoading: true));

    final productResponse =
        await productRepository.getDetailProduct(state.product.slug!);

    if (productResponse.isSuccess) {
      final product = productResponse.data;
      emit(state.copyWith(product: product));
    }
    emit(state.copyWith(isLoading: false));
  }

  _settingController() {
    pageController.addListener(() {
      final newIndex = pageController.page?.round() ?? 0;
      if (newIndex == state.indexImage) return;
      emit(state.copyWith(indexImage: newIndex));
    });

    controller.addListener(() {
      double currentScroll = controller.position.pixels;
      if (currentScroll - 20 <= 0) {
        if (state.isTop == false) {
          emit(state.copyWith(isTop: true));
        }
      } else {
        if (state.isTop == true) {
          emit(state.copyWith(isTop: false));
        }
      }
    });
  }

  actionCart(ProductCartActionEnum productCartAction) {
    switch (productCartAction) {
      case ProductCartActionEnum.addItem:
        _addItemToCart();
        break;
      default:
    }
  }

  _addItemToCart() async {
    final product = state.product;
    ItemCart itemCart = ItemCart(
        price: product.price!,
        id: product.id,
        name: product.name,
        quantity: 1,
        sellerName: product.seller?.info.name ?? '',
        discountPercent: product.discountPercent,
        mainCategory: product.category!.name,
        productImage: (product.productImages as List)
            .map((e) => ProductPicture.fromJson(e))
            .first
            .fileLink);
    addItemToCartMixin(itemCart: itemCart, type: ActionCartTypeEnum.local);
    await addItemToCartMixin(
        itemCart: getIt<FCartLocal>()
            .itemCarts
            .firstWhere((element) => element.id == itemCart.id),
        type: ActionCartTypeEnum.server);
  }
}
