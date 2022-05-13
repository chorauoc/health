import 'dart:convert';

import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 10)
class User extends HiveObject {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? gender;
  @HiveField(5)
  String? age;
  @HiveField(6)
  String? planerIndex;
  @HiveField(7)
  bool hasPlaner = false;
}
