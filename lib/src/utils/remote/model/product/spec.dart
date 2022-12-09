import 'package:json_annotation/json_annotation.dart';

part 'spec.g.dart';

@JsonSerializable()
class Spec {
  @JsonKey(name: 'author')
  String author;
  @JsonKey(name: 'publisher')
  String publisher;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'publicationDate')
  String publicationDate;

  Spec({
    this.author = '',
    this.publisher = '',
    this.city = '',
    this.publicationDate = '',
  });

  factory Spec.fromJson(Map<String, dynamic> json) => _$SpecFromJson(json);

  Map<String, dynamic> toJson() => _$SpecToJson(this);
}
