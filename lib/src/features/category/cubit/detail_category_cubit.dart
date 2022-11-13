import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'detail_category_state.dart';

enum DetailCategoryEnum { products, isEmpty }

class DetailCategoryCubit extends Cubit<DetailCategoryState>
    implements ParentCubit<DetailCategoryEnum> {
  DetailCategoryCubit({required String slugCategory})
      : super(DetailCategoryInitial(
            products: const [], slugCategory: slugCategory, isEmpty: false));
  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  int _currentPageProducts = 1;
  bool isLoadingProducts = false;

  void loadProducts() {
    if (isLoadingProducts) return;
    _currentPageProducts++;
    _getProducts();
  }

  void _getProducts() async {
    isLoadingProducts = true;
    final productsResponse = await productRepository.getProductsOfCategoryPage(
      numberPage: _currentPageProducts,
      categorySlug: state.slugCategory,
    );
    if (productsResponse.isSuccess) {
      addNewEvent(DetailCategoryEnum.products,
          [...state.products, ...productsResponse.data!]);
      addNewEvent(DetailCategoryEnum.isEmpty, false);
    }

    if (productsResponse.isError) {
      _currentPageProducts--;
      addNewEvent(DetailCategoryEnum.isEmpty, true);
    }

    isLoadingProducts = false;
  }

  @override
  void addNewEvent(DetailCategoryEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case DetailCategoryEnum.products:
        emit(
            NewDetailCategoryState.fromOldSettingState(state, products: value));
        break;
      case DetailCategoryEnum.isEmpty:
        emit(NewDetailCategoryState.fromOldSettingState(state, isEmpty: value));
        break;
      default:
    }
  }
}
