import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/main/home_product/repositories/product_repository.dart';
import 'package:it_project/src/features/main/home_product/repositories/product_repository_impl.dart';
import 'package:it_project/src/features/main/home_product/services/models/category.dart';
import 'package:it_project/src/features/main/home_product/services/models/product.dart';

part 'product_state.dart';

// enum LoginEnum { isLoading, isClickedLogin, announcementLogin }

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductInitial(products: [], categories: []));
  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  final meLocalKey = viVN;

  void productCallApi() async {
    final products = await productRepository.getProducts();
    final categories = await productRepository.getCategories();
    if (isClosed == false) {
      emit(NewProductState.fromOldSettingState(state, products: products));
      emit(NewProductState.fromOldSettingState(state, categories: categories));
    }
  }
}
