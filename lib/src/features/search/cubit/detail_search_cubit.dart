import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'detail_search_state.dart';

enum DetailSearchEnum { products, isLoading }

class DetailSearchCubit extends Cubit<DetailSearchState> {
  DetailSearchCubit()
      : super(const DetailSearchInitial(
          products: [],
          isLoading: false,
        ));

  final ProductRepository _productRepository = getIt<ProductRepositoryImpl>();

  int _currentPageProducts = 1;
  bool isLoadingProducts = false;

  String name = '';
  loadPageProducts(String name) async {
    if (isLoadingProducts) return;
    emit(state.copyWith(isLoading: true));

    if (name != this.name) {
      _currentPageProducts = 0;
      this.name = name;
      await _getProducts();
      emit(state.copyWith(isLoading: false));
      return;
    }

    _currentPageProducts++;
    _getProducts();

    emit(state.copyWith(isLoading: false));
  }

  _getProducts() async {
    isLoadingProducts = true;
    final productsResponse = await _productRepository.getProducts(
        numberPage: _currentPageProducts, name: name);
    if (productsResponse.isSuccess) {
      final products = productsResponse.data;
      emit(state.copyWith(products: products));
    }
    isLoadingProducts = false;
  }
}
