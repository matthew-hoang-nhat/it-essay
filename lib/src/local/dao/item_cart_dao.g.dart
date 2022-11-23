// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cart_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemCartAdapter extends TypeAdapter<ItemCart> {
  @override
  final int typeId = 0;

  @override
  ItemCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemCart(
      price: fields[7] as int,
      slug: fields[0] as String,
      name: fields[1] as String,
      quantity: fields[2] as int,
      sellerName: fields[3] as String,
      discountPercent: fields[4] as int,
      mainCategory: fields[5] as String,
      productImage: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemCart obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.slug)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.sellerName)
      ..writeByte(4)
      ..write(obj.discountPercent)
      ..writeByte(5)
      ..write(obj.mainCategory)
      ..writeByte(6)
      ..write(obj.productImage)
      ..writeByte(7)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
