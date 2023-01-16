import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/seller_repository.dart';
import 'package:it_project/src/utils/repository/seller_repository_impl.dart';

part 'category_product_state.dart';

enum CategoryProductEnum { products, isLoading }

class CategoryProductCubit extends Cubit<CategoryProductState>
    implements ParentCubit<CategoryProductEnum> {
  CategoryProductCubit({
    required String categoryId,
    required String sellerId,
  }) : super(CategoryProductInitial(
          products: const [],
          categoryId: categoryId,
          sellerId: sellerId,
          isLoading: false,
        ));
  final SellerRepository _sellerRepository = getIt<SellerRepositoryImpl>();

  bool _isLoadingProducts = false;

  loadProducts() async {
    addNewEvent(CategoryProductEnum.isLoading, true);
    if (_isLoadingProducts) return;
    await _getProducts();
    addNewEvent(CategoryProductEnum.isLoading, false);
  }

  _getProducts() async {
    _isLoadingProducts = true;
    final productsResponse = await _sellerRepository.getProducts(
        categoryId: state.categoryId,
        sellerId: state.sellerId,
        currentPage: 1,
        limit: 3);

    if (productsResponse.isSuccess) {
      addNewEvent(CategoryProductEnum.products,
          [...state.products, ...productsResponse.data!]);
    }

    _isLoadingProducts = false;
  }

  @override
  void addNewEvent(CategoryProductEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case CategoryProductEnum.products:
        emit(NewSellerState.fromOldSettingState(state, products: value));
        break;
      case CategoryProductEnum.isLoading:
        emit(NewSellerState.fromOldSettingState(state, isLoading: value));
        break;

      default:
    }
  }
}
