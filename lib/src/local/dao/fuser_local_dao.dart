// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'fuser_local_dao.g.dart';

@HiveType(typeId: 1)
class FUserLocalDao extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? phoneNumber;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? avatar;
  @HiveField(4)
  final String? accessToken;
  @HiveField(5)
  final String? refreshToken;
  @HiveField(6)
  final String? userId;
  @HiveField(7)
  final String? address;
  @HiveField(8)
  final String? birthDay;
  @HiveField(9)
  final String? gender;

  FUserLocalDao({
    this.name,
    this.phoneNumber,
    this.email,
    this.avatar,
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.address,
    this.birthDay,
    this.gender,
  });

  FUserLocalDao copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? avatar,
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? address,
    String? birthDay,
    String? gender,
  }) {
    return FUserLocalDao(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
    );
  }
}
