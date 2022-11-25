part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState(
      {
      // required this.slug,
      required this.product,
      required this.isTop,
      required this.isLoading,
      required this.indexImage,
      required this.isDescribeShowAll,
      required this.pageController,
      required this.controller});

  final Product product;
  final bool isTop;
  final bool isLoading;
  final bool isDescribeShowAll;
  final int indexImage;

  final PageController pageController;
  final ScrollController controller;

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
  const ProductInitial(
      {required super.product,
      // required super.slug,
      required super.isLoading,
      required super.isTop,
      required super.indexImage,
      required super.isDescribeShowAll,
      required super.pageController,
      required super.controller});
}

class NewProductState extends ProductState {
  NewProductState.fromOldSettingState(
    ProductState oldState, {
    Product? product,
    // String? slug,
    bool? isTop,
    bool? isDescribeShowAll,
    bool? isLoading,
    int? indexImage,
    PageController? pageController,
    ScrollController? controller,
  }) : super(
          product: product ?? oldState.product,
          isTop: isTop ?? oldState.isTop,
          indexImage: indexImage ?? oldState.indexImage,
          // slug: slug ?? oldState.slug,
          controller: controller ?? oldState.controller,
          isLoading: isLoading ?? oldState.isLoading,
          isDescribeShowAll: isDescribeShowAll ?? oldState.isDescribeShowAll,
          pageController: pageController ?? oldState.pageController,
        );
}
