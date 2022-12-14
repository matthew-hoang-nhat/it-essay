import 'package:json_annotation/json_annotation.dart';

part 'order_status.g.dart';

@JsonSerializable()
class OrderStatus {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'isCompleted')
  bool isCompleted;

  @JsonKey(name: '_id')
  String id;

  OrderStatus({
    required this.type,
    required this.date,
    required this.isCompleted,
    required this.id,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
