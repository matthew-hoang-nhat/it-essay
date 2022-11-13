part of 'detail_category_cubit.dart';

abstract class DetailCategoryState extends Equatable {
  const DetailCategoryState({
    required this.products,
    required this.slugCategory,
    required this.isEmpty,
  });

  final List<Product> products;
  final String slugCategory;
  final bool isEmpty;

  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [products];
}

class DetailCategoryInitial extends DetailCategoryState {
  const DetailCategoryInitial({
    required super.products,
    required super.slugCategory,
    required super.isEmpty,
  });
}

class NewDetailCategoryState extends DetailCategoryState {
  NewDetailCategoryState.fromOldSettingState(
    DetailCategoryState oldState, {
    List<Product>? products,
    String? slugCategory,
    bool? isEmpty,
  }) : super(
          products: products ?? oldState.products,
          slugCategory: slugCategory ?? oldState.slugCategory,
          isEmpty: isEmpty ?? oldState.isEmpty,
        );
}
