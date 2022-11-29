part of 'category_product_cubit.dart';

abstract class CategoryProductState extends Equatable {
  const CategoryProductState({
    required this.products,
    required this.sellerId,
    required this.categoryId,
  });

  final List<Product> products;
  final String categoryId;
  final String sellerId;

  @override
  List<Object> get props => [products];
}

class CategoryProductInitial extends CategoryProductState {
  const CategoryProductInitial({
    required super.products,
    required super.categoryId,
    required super.sellerId,
  });
}

class NewSellerState extends CategoryProductState {
  NewSellerState.fromOldSettingState(
    CategoryProductState oldState, {
    List<Product>? products,
    String? categoryId,
    String? sellerId,
  }) : super(
          products: products ?? oldState.products,
          sellerId: sellerId ?? oldState.sellerId,
          categoryId: categoryId ?? oldState.categoryId,
        );
}
