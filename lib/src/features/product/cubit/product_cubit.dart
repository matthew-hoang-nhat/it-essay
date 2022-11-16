import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'product_state.dart';

enum ProductEnum {
  isTop,
  product,
  indexImage,
  isDescribeShowAll,
}

class ProductCubit extends Cubit<ProductState>
    implements ParentCubit<ProductEnum> {
  ProductCubit({required Product product})
      : super(ProductInitial(
          isTop: true,
          controller: ScrollController(),
          product: product,
          indexImage: 0,
          pageController: PageController(),
          isDescribeShowAll: false,
        ));

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  final meLocalKey = viVN;
  getDetailProduct() async {
    final productResponse =
        await productRepository.getDetailProduct(state.product.slug);

    if (productResponse.isSuccess) {
      addNewEvent(ProductEnum.product, productResponse.data);
      print(productResponse.data?.seller?.toJson());
      return;
    }

    // print('get thất bại');

    // final mockData = mockProduct;
    // addNewEvent(ProductEnum.product, mockData);
  }

  settingController() {
    state.pageController.addListener(() {
      final newIndex = state.pageController.page?.round() ?? 0;
      if (newIndex == state.indexImage) return;
      addNewEvent(ProductEnum.indexImage, newIndex);
    });

    state.controller.addListener(() {
      double currentScroll = state.controller.position.pixels;
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

  @override
  void addNewEvent(ProductEnum key, value) {
    print('addNewEvent ProductCubit');
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
      default:
    }
  }
}
