import 'dart:convert';

import 'package:hive/hive.dart';
part 'health.g.dart';

@HiveType(typeId: 11)
class Health extends HiveObject {
  @HiveField(0)
  int totalSteps = 0;
  @HiveField(1)
  int totalAppUsage = 0;
  @HiveField(2)
  int totalCalories = 0;
  @HiveField(3)
  int totalSleepTime = 0;
  @HiveField(4)
  List<HealthSteps> steps = [];
  @HiveField(5)
  List<HealthUsage> usage = [];
  @HiveField(6)
  List<HealthCalories> calories = [];
  @HiveField(7)
  List<HealthSleep> sleep = [];
  @HiveField(8)
  String? username;
  @HiveField(9)
  List<HealthQol> qol = [];
}


@HiveType(typeId: 12)
class HealthSteps extends HiveObject {
  @HiveField(0)
  String? datetime;
  @HiveField(1)
  int value = 0;

}

@HiveType(typeId: 13)
class HealthUsage extends HiveObject {
  @HiveField(0)
  String? datetime;
  @HiveField(1)
  int value = 0;
}

@HiveType(typeId: 14)
class HealthCalories extends HiveObject {
  @HiveField(0)
  String? datetime;
  @HiveField(1)
  int value = 0;
}

@HiveType(typeId: 15)
class HealthSleep extends HiveObject {
  @HiveField(0)
  String? datetime;
  @HiveField(1)
  int value = 0;
}

@HiveType(typeId: 16)
class HealthQol extends HiveObject {
  @HiveField(0)
  String? datetime;
  @HiveField(1)
  int value = 0;
}