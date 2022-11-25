part of 'category_product_cubit.dart';

abstract class CategoryProductState extends Equatable {
  const CategoryProductState({
    required this.products,
    required this.sellerId,
    required this.categoryId,
    required this.isLoading,
  });

  final List<Product> products;
  final String categoryId;
  final String sellerId;
  final bool isLoading;

  @override
  List<Object> get props => [products, isLoading];
}

class CategoryProductInitial extends CategoryProductState {
  const CategoryProductInitial({
    required super.products,
    required super.categoryId,
    required super.sellerId,
    required super.isLoading,
  });
}

class NewSellerState extends CategoryProductState {
  NewSellerState.fromOldSettingState(
    CategoryProductState oldState, {
    List<Product>? products,
    String? categoryId,
    String? sellerId,
    bool? isLoading,
  }) : super(
          products: products ?? oldState.products,
          sellerId: sellerId ?? oldState.sellerId,
          categoryId: categoryId ?? oldState.categoryId,
          isLoading: isLoading ?? oldState.isLoading,
        );
}
