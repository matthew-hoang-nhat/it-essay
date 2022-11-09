import 'package:json_annotation/json_annotation.dart';
part 'content_search.g.dart';

@JsonSerializable()
class ContentSearch {
  // @JsonKey(name: 'email')
  // String? email;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;

  ContentSearch({
    // this.email,
    this.name,
    this.slug,
  });

  factory ContentSearch.fromJson(Map<String, dynamic> json) =>
      _$ContentSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ContentSearchToJson(this);
}
