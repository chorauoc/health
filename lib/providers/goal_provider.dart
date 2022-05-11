import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/goal.dart';
import '../models/user.dart';

class GoalProvider with ChangeNotifier {
  Goal? _goal;

  GoalState update(Goal goal) {
    var box = Hive.box('goals');

    var filteredGoal =
        box.values.where((e) => e.username == goal.username).toList();

    if (filteredGoal.isNotEmpty) {
      Goal p = filteredGoal[0];
      p.username = goal.username;
      p.screenTime = goal.screenTime;
      p.activityGoal = goal.activityGoal;
      p.sleepGoal = goal.sleepGoal;
      p.stepsGoal = goal.stepsGoal;
      p.save();
    } else {
      box.add(goal);
    }
    _goal = goal;
    return GoalState.completed;
  }

  Goal? getGoals() {
    return _goal;
  }

  void notify() {
    notifyListeners();
  }
}

enum GoalState {
  loading,
  completed,
  error,
  exsist,
  notExsist,
}
