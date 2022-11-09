import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'home_state.dart';

enum HomeEnum { products, categories }

class HomeCubit extends Cubit<HomeState> implements ParentCubit<HomeEnum> {
  HomeCubit() : super(const HomeInitial(products: [], categories: []));
  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  final meLocalKey = viVN;

  void productCallApi() async {
    final productsResponse = await productRepository.getProducts();
    if (productsResponse.isSuccess) {
      addNewEvent(HomeEnum.products, productsResponse.data);
    }

    final categoriesResponse = await productRepository.getCategories();
    if (categoriesResponse.isSuccess) {
      addNewEvent(HomeEnum.categories, categoriesResponse.data);
    }
  }

  @override
  void addNewEvent(HomeEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case HomeEnum.products:
        emit(NewHomeState.fromOldSettingState(state, products: value));
        break;
      case HomeEnum.categories:
        emit(NewHomeState.fromOldSettingState(state, categories: value));
        break;
      default:
    }
  }
}
