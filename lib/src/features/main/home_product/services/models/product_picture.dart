import 'package:json_annotation/json_annotation.dart';
part 'product_picture.g.dart';

@JsonSerializable()
class ProductPicture {
  @JsonKey(name: 'fileLink')
  String fileLink;

  ProductPicture({required this.fileLink});

  factory ProductPicture.fromJson(Map<String, dynamic> json) =>
      _$ProductPictureFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPictureToJson(this);
}
