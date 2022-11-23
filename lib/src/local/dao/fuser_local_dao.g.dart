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
      firstName: fields[0] as String?,
      lastName: fields[10] as String?,
      phoneNumber: fields[1] as String?,
      email: fields[2] as String?,
      avatar: fields[3] as String?,
      accessToken: fields[4] as String?,
      refreshToken: fields[5] as String?,
      userId: fields[6] as String?,
      address: fields[7] as String?,
      birthDay: fields[8] as String?,
      gender: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FUserLocalDao obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.firstName)
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
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.birthDay)
      ..writeByte(9)
      ..write(obj.gender)
      ..writeByte(10)
      ..write(obj.lastName);
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
