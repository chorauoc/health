import 'package:flutter/cupertino.dart';

import '../main.dart';
import '../models/goal.dart';
import '../models/health.dart';
import '../models/plans/data_set.dart';
import '../models/user.dart';
import '../providers/app_provider.dart';
import '../providers/goal_provider.dart';
import '../providers/user_provider.dart';

class HealthCalculation {
  static bool isBetween(var val, var from, var to) {
    print('isBetween $val from $from to $to');
    return double.parse(from.toString()) <= double.parse(val.toString()) &&
        double.parse(val.toString()) <= double.parse(to.toString());
  }

  static double calculateQualityOfLifeValue(Health health) {
    User? user = locator<UserProvider>().getSession();

    var age;
    var gender;
    var screenTime;
    var activity;
    var sleep;
    var steps;

    if (user != null && user.gender == 'Male') {
      gender = dataSetGender['Male'];
    } else {
      gender = dataSetGender['Female'];
    }

    if (user != null && isBetween(user.age, 0, 10)) {
      age = dataSetAge['Age_12 - 20'];
    } else if (user != null && isBetween(user.age, 20, 40)) {
      age = dataSetAge['Age_20 - 40'];
    } else if (user != null && isBetween(user.age, 40, 60)) {
      age = dataSetAge['Age_40 - 60'];
    } else {
      age = dataSetAge['Age_Above 60'];
    }

    if (isBetween(double.parse(health.totalAppUsage.toString()), 0, 3)) {
      screenTime = dataSetScreenTime['ScreenTime_1-3 Hours'];
    } else if (isBetween(double.parse(health.totalAppUsage.toString()), 3, 6)) {
      screenTime = dataSetScreenTime['ScreenTime_3-6 Hours'];
    } else if (isBetween(double.parse(health.totalAppUsage.toString()), 6, 9)) {
      screenTime = dataSetScreenTime['ScreenTime_6-9 Hours'];
    } else {
      screenTime = dataSetScreenTime['ScreenTime_9+ Hours'];
    }

    if (isBetween(double.parse(health.totalCalories.toString()), 100, 300)) {
      activity = dataSetActivity['WorkOut_1-2 Days (cal 100-300)'];
    } else if (isBetween(
        double.parse(health.totalCalories.toString()), 300, 600)) {
      activity = dataSetActivity['WorkOut_3-4 Days (cal 300-600)'];
    } else if (isBetween(
        double.parse(health.totalCalories.toString()), 600, 1200)) {
      activity = dataSetActivity['WorkOut_4 + Days ( (cal 600-1200)'];
    } else {
      activity = dataSetActivity['WorkOut_Not at all ( cal >100)'];
    }

    if (isBetween(double.parse(health.totalSleepTime.toString()), 3, 4)) {
      sleep = dataSetSleepTime['SleepTime_3-4 Hours'];
    } else if (isBetween(
        double.parse(health.totalSleepTime.toString()), 4, 5)) {
      sleep = dataSetSleepTime['SleepTime_4-5 Hours'];
    } else if (isBetween(
        double.parse(health.totalSleepTime.toString()), 5, 6)) {
      sleep = dataSetSleepTime['SleepTime_5-6 Hours'];
    } else if (isBetween(
        double.parse(health.totalSleepTime.toString()), 6, 7)) {
      sleep = dataSetSleepTime['SleepTime_6-7 Hours'];
    } else if (isBetween(
        double.parse(health.totalSleepTime.toString()), 7, 8)) {
      sleep = dataSetSleepTime['SleepTime_7-8 Hours'];
    } else if (isBetween(
        double.parse(health.totalSleepTime.toString()), 8, 9)) {
      sleep = dataSetSleepTime['SleepTime_8-9 Hours'];
    } else {
      sleep = dataSetSleepTime['SleepTime_9+ Hours'];
    }

    if (isBetween(double.parse(health.totalSteps.toString()), 1000, 3000)) {
      steps = dataSetSteps['Steps_1000 - 3000 Steps'];
    } else if (isBetween(
        double.parse(health.totalSteps.toString()), 3000, 5000)) {
      steps = dataSetSteps['Steps_3000 - 5000 Steps'];
    } else if (isBetween(
        double.parse(health.totalSteps.toString()), 5000, 7000)) {
      steps = dataSetSteps['Steps_5000 - 7000 Steps'];
    } else if (isBetween(
        double.parse(health.totalSteps.toString()), 7000, 1000)) {
      steps = dataSetSteps['Steps_7000 - 1000 Steps'];
    } else {
      steps = dataSetSteps['Steps_less than 1000 steps'];
    }

    print('calculateQualityOfLifeValue age $age');
    print('calculateQualityOfLifeValue gender $gender');
    print('calculateQualityOfLifeValue screenTime $screenTime');
    print('calculateQualityOfLifeValue activity $activity');
    print('calculateQualityOfLifeValue sleep $sleep');
    print('calculateQualityOfLifeValue steps $steps');
    print('calculateQualityOfLifeValue permanent_value $permanent_value');

    var rs = (double.parse(age.toString()) +
        double.parse(gender.toString()) +
        double.parse(screenTime.toString()) +
        double.parse(activity.toString()) +
        double.parse(sleep.toString()) +
        double.parse(steps.toString()) +
        permanent_value);
    var result = double.parse((rs/100).toString()).toStringAsExponential(0);
    print('calculateQualityOfLifeValue result=> $result');
    return double.parse(result);
  }

  static double calculateAtivityValue(Health health) {
    User? user = locator<UserProvider>().getSession();
    Goal? goal = locator<GoalProvider>().getGoals();
    double activityValue =
        goal?.activityGoal != null && goal?.activityGoal != '0'
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
