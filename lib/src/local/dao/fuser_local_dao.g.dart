// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuser_local_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FUserLocalDaoAdapter extends TypeAdapter<FUserLocalDao> {
  @override
  final int typeId = 1;

  @override
  FUserLocalDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FUserLocalDao(
      name: fields[0] as String?,
      phoneNumber: fields[1] as String?,
      email: fields[2] as String?,
      avatar: fields[3] as String?,
      accessToken: fields[4] as String?,
      refreshToken: fields[5] as String?,
      userId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FUserLocalDao obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.avatar)
      ..writeByte(4)
      ..write(obj.accessToken)
      ..writeByte(5)
      ..write(obj.refreshToken)
      ..writeByte(6)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FUserLocalDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
