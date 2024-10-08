import 'package:hive_flutter/adapters.dart';

part 'singInModel.g.dart';

@HiveType(typeId: 1)
class Singinmodel {
  @HiveField(0)
  String? username;

  @HiveField(1)
  String? password;

  @HiveField(2)
  String? id;

  @HiveField(3)
  String? image;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? phone;

  Singinmodel(
      {this.username,
      this.password,
      this.id,
      this.email,
      this.phone,
      this.image});
}
