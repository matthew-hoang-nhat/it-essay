part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState(
      {
      // required this.slug,
      required this.product,
      required this.isTop,
      required this.controller});

  final Product product;
  // final String slug;
  final bool isTop;
  final ScrollController controller;

  // final Map<String, String> meLocalKey;

  @override
  List<Object?> get props => [product, isTop];
}

class ProductInitial extends ProductState {
  const ProductInitial(
      {required super.product,
      // required super.slug,
      required super.isTop,
      required super.controller});
}

class NewProductState extends ProductState {
  NewProductState.fromOldSettingState(
    ProductState oldState, {
    Product? product,
    // String? slug,
    bool? isTop,
    ScrollController? controller,
  }) : super(
          product: product ?? oldState.product,
          isTop: isTop ?? oldState.isTop,
          // slug: slug ?? oldState.slug,
          controller: controller ?? oldState.controller,
        );
}
