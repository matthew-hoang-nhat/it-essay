// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.product,
    required this.isTop,
    required this.isLoading,
    required this.indexImage,
    required this.isEndReviews,
    required this.isDescribeShowAll,
    required this.reviews,
    required this.isLoadingMore,
    required this.isBoughtProduct,
  });

  final Product? product;
  final bool isTop;
  final bool isLoading;
  final bool isDescribeShowAll;
  final bool isEndReviews;
  final bool isLoadingMore;
  final bool isBoughtProduct;
  final int indexImage;
  final List<Review> reviews;

  @override
  List<Object?> get props => [
        product,
        isTop,
        indexImage,
        isEndReviews,
        isDescribeShowAll,
        isLoadingMore,
        isBoughtProduct,
        isLoading,
        reviews,
      ];

  ProductState copyWith({
    Product? product,
    bool? isTop,
    bool? isLoading,
    bool? isDescribeShowAll,
    bool? isEndReviews,
    bool? isLoadingMore,
    bool? isBoughtProduct,
    int? indexImage,
    List<Review>? reviews,
  }) {
    return ProductState(
      product: product ?? this.product,
      isTop: isTop ?? this.isTop,
      isLoading: isLoading ?? this.isLoading,
      isDescribeShowAll: isDescribeShowAll ?? this.isDescribeShowAll,
      indexImage: indexImage ?? this.indexImage,
      reviews: reviews ?? this.reviews,
      isEndReviews: isEndReviews ?? this.isEndReviews,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isBoughtProduct: isBoughtProduct ?? this.isBoughtProduct,
    );
  }
}

class ProductInitial extends ProductState {
  const ProductInitial({
    required super.product,
    required super.isLoading,
    required super.isBoughtProduct,
    required super.isTop,
    required super.indexImage,
    required super.isDescribeShowAll,
    required super.reviews,
    required super.isLoadingMore,
    required super.isEndReviews,
  });
}
