import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/app/f_cart_local.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/utils/remote/model/review/review.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/review_repository_impl.dart';

part 'product_state.dart';

enum ProductCartActionEnum {
  addItem,
}

enum TypeLoad { refresh, loadMore }

class ProductCubit extends Cubit<ProductState> with ActionCart {
  ProductCubit()
      : super(const ProductInitial(
            isTop: true,
            product: null,
            indexImage: 0,
            isDescribeShowAll: false,
            isLoading: false,
            isLoadingMore: false,
            reviews: [],
            isBoughtProduct: false,
            isEndReviews: false));

  final controller = ScrollController();
  final pageController = PageController();

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();

  final meLocalKey = viVN;

  initCubit(String slug) async {
    _getDetailProduct(slug).then((value) {
      _getReviewsOfAProduct(TypeLoad.refresh);
      _checkPermissionReview();
    });
    _settingController();
  }

  _checkPermissionReview() async {
    if (state.product == null) return;
    final result =
        await reviewRepo.isBoughtProduct(idProduct: state.product!.id);

    if (result.data == true) {
      emit(state.copyWith(isBoughtProduct: true));
    }
  }

  Future<bool> deleteReview(Review review) async {
    final result = await reviewRepo.deleteReview(
        discussId: review.id, page: review.page, productId: state.product!.id);

    if (result.isSuccess) {
      final newReviews = List<Review>.from(state.reviews);
      newReviews.removeWhere(
        (Review element) => element.id == review.id,
      );
      emit(state.copyWith(reviews: newReviews));
      Fluttertoast.showToast(msg: 'Xóa đánh giá thành công');
      return true;
    }

    Fluttertoast.showToast(
        msg: 'Không thể xóa đánh giá',
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor);
    return false;
  }

  loadReviews(TypeLoad type) async {
    switch (type) {
      case TypeLoad.refresh:
        emit(state.copyWith(isLoadingMore: true));
        currentPageNumberReviews = 1;
        emit(state.copyWith(isEndReviews: false));
        await _getReviewsOfAProduct(TypeLoad.refresh);
        emit(state.copyWith(isLoadingMore: false));
        break;
      case TypeLoad.loadMore:
        if (state.isEndReviews) return;
        emit(state.copyWith(isLoadingMore: true));
        currentPageNumberReviews++;
        await _getReviewsOfAProduct(TypeLoad.loadMore);
        emit(state.copyWith(isLoadingMore: false));
        break;
      default:
    }
  }

  setShowAll() {
    emit(state.copyWith(isDescribeShowAll: true));
  }

  Future<void> _getDetailProduct(slug) async {
    emit(state.copyWith(isLoading: true));
    final productResponse = await productRepository.getDetailProduct(slug);

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
    final product = state.product!;
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

  int currentPageNumberReviews = 1;
  final reviewRepo = getIt<ReviewRepositoryImpl>();
  _getReviewsOfAProduct(TypeLoad type) async {
    final result = await reviewRepo.getReviewsOfAProduct(
        idProduct: state.product!.id, numberPage: currentPageNumberReviews);

    if (result.isSuccess) {
      final reviews = result.data!;
      if (type == TypeLoad.refresh) {
        emit(state.copyWith(reviews: [...reviews]));
      }
      if (type == TypeLoad.loadMore) {
        emit(state.copyWith(reviews: [...state.reviews, ...reviews]));
      }
    }
    if (result.isError) {
      emit(state.copyWith(isEndReviews: true));
    }
  }
}
