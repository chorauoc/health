import 'package:flutter/cupertino.dart';

import '../main.dart';
import '../models/goal.dart';
import '../models/health.dart';
import '../models/user.dart';
import '../providers/app_provider.dart';
import '../providers/goal_provider.dart';
import '../providers/user_provider.dart';

class HealthCalculation {
  static double calculateQualityOfLifeValue(Health health) {
    User? user = locator<UserProvider>().getSession();
    Goal? goal = locator<GoalProvider>().getGoals();
    var v1 = double.parse(health.totalAppUsage.toString()) +
        double.parse(health.totalSleepTime.toString()) +
        double.parse(health.totalSteps.toString()) +
        double.parse(health.totalCalories.toString());

    var v2 = double.parse(goal?.screenTime ?? '0') +
        double.parse(goal?.sleepGoal ?? '0') +
        double.parse(goal?.stepsGoal ?? '0') +
        double.parse(goal?.activityGoal ?? '0');

    return v2==0 ? 0:roundUp(v1 / v2);
  }

  static double calculateAtivityValue(Health health) {
    User? user = locator<UserProvider>().getSession();
    Goal? goal = locator<GoalProvider>().getGoals();
    double activityValue = goal?.activityGoal != null && goal?.activityGoal != '0'
        ? (double.parse(health.totalCalories.toString()) /
            double.parse(goal?.activityGoal ?? '0'))
        : 0;
    return roundUp(activityValue);
  }

  static double calculateStepsValue(Health health) {
    User? user = locator<UserProvider>().getSession();
    Goal? goal = locator<GoalProvider>().getGoals();
    double stepsValue = goal?.stepsGoal != null && goal?.stepsGoal != '0'
        ? (double.parse(health.totalSteps.toString()) /
            double.parse(goal?.stepsGoal ?? '0'))
        : 0;
    return roundUp(stepsValue);
  }

  static double calculateSleepTimeValue(Health health) {
    User? user = locator<UserProvider>().getSession();
    Goal? goal = locator<GoalProvider>().getGoals();
    double sleepTimeValue = goal?.sleepGoal != null && goal?.sleepGoal != '0'
        ? (double.parse(health.totalSleepTime.toString()) /
            double.parse(goal?.sleepGoal ?? '0'))
        : 0;
    return roundUp(sleepTimeValue);
  }

  static double calculateScreenTimeValue(Health health) {
    User? user = locator<UserProvider>().getSession();
    Goal? goal = locator<GoalProvider>().getGoals();
    double screenTimeValue = goal?.screenTime != null && goal?.screenTime != '0'
        ? (double.parse(health.totalAppUsage.toString()) /
            double.parse(goal?.screenTime ?? '0'))
        : 0;
    return roundUp(screenTimeValue);
  }

  static double roundUp(double value) {
    double rs = double.parse(value.toStringAsExponential(1));
    return rs > 1 ? 1 : rs;
  }
}
