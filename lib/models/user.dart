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
  bool hasPlaner = false;
}
