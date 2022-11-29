import 'package:json_annotation/json_annotation.dart';
part 'content_search.g.dart';

enum ContentTypeEnum { product, category }

Map<String, ContentTypeEnum> contentSearchType = {
  'product': ContentTypeEnum.product,
  'category': ContentTypeEnum.category,
};

@JsonSerializable()
class ContentSearch {
  // @JsonKey(name: 'email')
  // String? email;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'slug')
  String slug;
  @JsonKey(name: 'type')
  String type;

  ContentSearch({
    // this.email,
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
  });

  factory ContentSearch.fromJson(Map<String, dynamic> json) =>
      _$ContentSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ContentSearchToJson(this);
}
