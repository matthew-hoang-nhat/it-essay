part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState(
      {
      // required this.emailController,
      // required this.passwordController,
      required this.products,
      required this.categories,
      required this.flashSaleProducts
      // required this.meLocalKey
      });
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final List<Product> products;
  final List<Category> categories;
  final List<Product> flashSaleProducts;

  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [products, categories, flashSaleProducts];
}

class HomeInitial extends HomeState {
  const HomeInitial(
      {
      //   required super.emailController,
      // required super.passwordController,
      required super.products,
      required super.categories,
      required super.flashSaleProducts
      // required super.meLocalKey
      });
}

class NewHomeState extends HomeState {
  NewHomeState.fromOldSettingState(HomeState oldState,
      {
      // TextEditingController? emailController,
      // TextEditingController? passwordController,
      List<Product>? products,
      List<Product>? flashSaleProducts,
      List<Category>? categories
      // Map<String, String>? meLocalKey,
      })
      : super(
          products: products ?? oldState.products,
          flashSaleProducts: flashSaleProducts ?? oldState.flashSaleProducts,
          categories: categories ?? oldState.categories,
        );
}
