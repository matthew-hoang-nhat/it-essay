var mockProductGeneralModel = ProductGeneralModel(
    mainCategory: 'Sách thiếu nhi',
    name: 'Chú dế mèn kêu phiêu lưu kí',
    price: '29000',
    priceAfterDecrement: '25000',
    productImage: null);

class ProductGeneralModel {
  ProductGeneralModel({
    required this.name,
    required this.mainCategory,
    required this.price,
    required this.priceAfterDecrement,
    required this.productImage,
  });
  String name;
  String mainCategory;
  String price;
  String priceAfterDecrement;
  String? productImage;
}
