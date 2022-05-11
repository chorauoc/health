import 'dart:convert';

import 'package:hive/hive.dart';
part 'goal.g.dart';

@HiveType(typeId: 100)
class Goal extends HiveObject {
  @HiveField(0)
  String? sleepGoal;
  @HiveField(1)
  String? activityGoal;
  @HiveField(2)
  String? screenTime;
  @HiveField(3)
  String? stepsGoal;
  @HiveField(4)
  String? username;
}
