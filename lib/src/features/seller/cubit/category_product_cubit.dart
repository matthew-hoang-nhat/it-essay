import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/seller_repository.dart';
import 'package:it_project/src/utils/repository/seller_repository_impl.dart';

part 'category_product_state.dart';

enum CategoryProductEnum { products }

class CategoryProductCubit extends Cubit<CategoryProductState>
    implements ParentCubit<CategoryProductEnum> {
  CategoryProductCubit({
    required String categoryId,
    required String sellerId,
  }) : super(CategoryProductInitial(
          products: const [],
          categoryId: categoryId,
          sellerId: sellerId,
        ));
  final SellerRepository _sellerRepository = getIt<SellerRepositoryImpl>();

  bool _isLoadingProducts = false;

  void loadProducts() {
    if (_isLoadingProducts) return;
    _getProducts();
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

      default:
    }
  }
}
