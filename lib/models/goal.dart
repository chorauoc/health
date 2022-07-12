import 'dart:convert';

import 'package:hive/hive.dart';
part 'goal.g.dart';

@HiveType(typeId: 100)
class Goal extends HiveObject {
  @HiveField(0)
  String sleepGoal = '0';
  @HiveField(1)
  String activityGoal = '0';
  @HiveField(2)
  String screenTime = '0';
  @HiveField(3)
  String stepsGoal = '0';
  @HiveField(4)
  String? username;
}
