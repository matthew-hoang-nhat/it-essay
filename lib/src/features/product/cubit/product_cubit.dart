import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'product_state.dart';

enum ProductEnum { slug, isTop, product }

class ProductCubit extends Cubit<ProductState>
    implements ParentCubit<ProductEnum> {
  ProductCubit({required String superSlug})
      : super(ProductInitial(slug: superSlug, isTop: true));

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  final meLocalKey = viVN;

  getDetailProduct() async {
    final productResponse =
        await productRepository.getDetailProduct(state.slug);
    if (productResponse.isError) {
      addNewEvent(ProductEnum.product, productResponse.data);
    }
  }

  @override
  void addNewEvent(ProductEnum key, value) {
    switch (key) {
      case ProductEnum.isTop:
        emit(NewProductState.fromOldSettingState(state, isTop: value));
        break;
      case ProductEnum.slug:
        emit(NewProductState.fromOldSettingState(state, slug: value));
        break;
      case ProductEnum.product:
        emit(NewProductState.fromOldSettingState(state, product: value));
        break;
      default:
    }
  }
}
