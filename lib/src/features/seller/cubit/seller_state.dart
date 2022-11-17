// part of 'seller_cubit.dart';

// abstract class SellerState extends Equatable {
//   const SellerState({
//     required this.products,
//     required this.sellerId,
//     required this.isEmpty,
//     required this.controller,
//   });

//   final List<Product> products;
//   final String sellerId;
//   final bool isEmpty;
//   final ScrollController controller;

//   // final Map<String, String> meLocalKey;

//   @override
//   List<Object> get props => [products];
// }

// class DetailSellerInitial extends SellerState {
//   const DetailSellerInitial({
//     required super.products,
//     required super.sellerId,
//     required super.isEmpty,
//     required super.controller,
//   });
// }

// class NewSellerState extends SellerState {
//   NewSellerState.fromOldSettingState(
//     SellerState oldState, {
//     List<Product>? products,
//     String? sellerId,
//     bool? isEmpty,
//     ScrollController? controller,
//   }) : super(
//           products: products ?? oldState.products,
//           sellerId: sellerId ?? oldState.sellerId,
//           isEmpty: isEmpty ?? oldState.isEmpty,
//           controller: controller ?? oldState.controller,
//         );
// }
