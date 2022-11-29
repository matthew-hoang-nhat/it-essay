part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState({
    required this.product,
    required this.isTop,
    required this.isLoading,
    required this.indexImage,
    required this.isDescribeShowAll,
  });

  final Product product;
  final bool isTop;
  final bool isLoading;
  final bool isDescribeShowAll;
  final int indexImage;

  @override
  List<Object?> get props => [
        product,
        isTop,
        indexImage,
        isDescribeShowAll,
        isLoading,
      ];
}

class ProductInitial extends ProductState {
  const ProductInitial({
    required super.product,
    // required super.slug,
    required super.isLoading,
    required super.isTop,
    required super.indexImage,
    required super.isDescribeShowAll,
  });
}

class NewProductState extends ProductState {
  NewProductState.fromOldSettingState(
    ProductState oldState, {
    Product? product,
    bool? isTop,
    bool? isDescribeShowAll,
    bool? isLoading,
    int? indexImage,
  }) : super(
          product: product ?? oldState.product,
          isTop: isTop ?? oldState.isTop,
          indexImage: indexImage ?? oldState.indexImage,
          isLoading: isLoading ?? oldState.isLoading,
          isDescribeShowAll: isDescribeShowAll ?? oldState.isDescribeShowAll,
        );
}
