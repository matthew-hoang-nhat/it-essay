// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

class ProductState extends Equatable {
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

  ProductState copyWith({
    Product? product,
    bool? isTop,
    bool? isLoading,
    bool? isDescribeShowAll,
    int? indexImage,
  }) {
    return ProductState(
      product: product ?? this.product,
      isTop: isTop ?? this.isTop,
      isLoading: isLoading ?? this.isLoading,
      isDescribeShowAll: isDescribeShowAll ?? this.isDescribeShowAll,
      indexImage: indexImage ?? this.indexImage,
    );
  }
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
