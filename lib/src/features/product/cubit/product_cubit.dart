import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'product_state.dart';

enum ProductEnum {
  isTop,
  product,
  indexImage,
  isDescribeShowAll,
  isLoading,
}

enum ProductCartActionEnum {
  addItem,
}

class ProductCubit extends Cubit<ProductState>
    with ActionCart
    implements ParentCubit<ProductEnum> {
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

  _getDetailProduct() async {
    addNewEvent(ProductEnum.isLoading, true);
    final productResponse =
        await productRepository.getDetailProduct(state.product.slug);

    if (productResponse.isSuccess) {
      addNewEvent(ProductEnum.product, productResponse.data);
    }
    addNewEvent(ProductEnum.isLoading, false);
  }

  _settingController() {
    pageController.addListener(() {
      final newIndex = pageController.page?.round() ?? 0;
      if (newIndex == state.indexImage) return;
      addNewEvent(ProductEnum.indexImage, newIndex);
    });

    controller.addListener(() {
      double currentScroll = controller.position.pixels;
      if (currentScroll - 20 <= 0) {
        if (state.isTop == false) {
          addNewEvent(ProductEnum.isTop, true);
        }
      } else {
        if (state.isTop == true) {
          addNewEvent(ProductEnum.isTop, false);
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
        price: product.price,
        id: product.id,
        name: product.name,
        quantity: 1,
        sellerName: product.seller?.info.name ?? '',
        discountPercent: product.discountPercent,
        mainCategory: product.category.name,
        productImage: (product.productImages as List)
            .map((e) => ProductPicture.fromJson(e))
            .first
            .fileLink);
    addItemToCartLocal(itemCart);
    await addItemToCartServer(itemCart);
  }

  @override
  void addNewEvent(ProductEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case ProductEnum.isTop:
        emit(NewProductState.fromOldSettingState(state, isTop: value));
        break;
      // case ProductEnum.slug:
      //   emit(NewProductState.fromOldSettingState(state, slug: value));
      //   break;
      case ProductEnum.product:
        emit(NewProductState.fromOldSettingState(state, product: value));
        break;
      case ProductEnum.isDescribeShowAll:
        emit(NewProductState.fromOldSettingState(state,
            isDescribeShowAll: value));
        break;
      case ProductEnum.indexImage:
        emit(NewProductState.fromOldSettingState(state, indexImage: value));
        break;
      case ProductEnum.isLoading:
        emit(NewProductState.fromOldSettingState(state, isLoading: value));
        break;
      default:
    }
  }
}
