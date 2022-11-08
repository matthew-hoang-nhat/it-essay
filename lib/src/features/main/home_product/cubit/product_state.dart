part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState(
      {
      // required this.emailController,
      // required this.passwordController,
      required this.products,
      required this.categories
      // required this.meLocalKey
      });
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final List<Product> products;
  final List<Category> categories;

  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [products, categories];
}

class ProductInitial extends ProductState {
  const ProductInitial(
      {
      //   required super.emailController,
      // required super.passwordController,
      required super.products,
      required super.categories
      // required super.meLocalKey
      });
}

class NewProductState extends ProductState {
  NewProductState.fromOldSettingState(ProductState oldState,
      {
      // TextEditingController? emailController,
      // TextEditingController? passwordController,
      List<Product>? products,
      List<Category>? categories
      // Map<String, String>? meLocalKey,
      })
      : super(
          products: products ?? oldState.products,
          categories: categories ?? oldState.categories,
        );
}
