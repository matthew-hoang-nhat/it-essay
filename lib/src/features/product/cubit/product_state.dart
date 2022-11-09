part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState({
    required this.slug,
    this.product,
    required this.isTop,
  });

  final Product? product;
  final String slug;
  final bool isTop;

  // final Map<String, String> meLocalKey;

  @override
  List<Object?> get props => [product, slug, isTop];
}

class ProductInitial extends ProductState {
  const ProductInitial(
      {super.product, required super.slug, required super.isTop});
}

class NewProductState extends ProductState {
  NewProductState.fromOldSettingState(
    ProductState oldState, {
    Product? product,
    String? slug,
    bool? isTop,
  }) : super(
          product: product ?? oldState.product,
          isTop: isTop ?? oldState.isTop,
          slug: slug ?? oldState.slug,
        );
}
