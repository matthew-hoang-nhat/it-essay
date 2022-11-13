import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'detail_search_state.dart';

enum DetailSearchEnum {
  products,
}

class DetailSearchCubit extends Cubit<DetailSearchState>
    implements ParentCubit<DetailSearchEnum> {
  DetailSearchCubit()
      : super(const DetailSearchInitial(
          products: [],
        ));

  final ProductRepository _productRepository = getIt<ProductRepositoryImpl>();

  int _currentPageProducts = 1;
  bool isLoadingProducts = false;

  String name = '';
  loadPageProducts(String name) {
    if (isLoadingProducts) return;

    if (name != this.name) {
      _currentPageProducts = 0;
      this.name = name;
      getProducts();
      return;
    }

    _currentPageProducts++;
    getProducts();
  }

  getProducts() async {
    isLoadingProducts = true;
    final productsResponse = await _productRepository.getProducts(
        numberPage: _currentPageProducts, name: name);
    if (productsResponse.isSuccess) {
      addNewEvent(DetailSearchEnum.products, productsResponse.data);
    }
    isLoadingProducts = false;
  }

  @override
  void addNewEvent(DetailSearchEnum key, value) {
    if (isClosed) {
      return;
    }
    switch (key) {
      case DetailSearchEnum.products:
        emit(NewDetailSearchState.fromOldSettingState(state, products: value));
        break;
    }
  }
}
