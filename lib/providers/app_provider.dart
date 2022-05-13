import 'dart:math';

import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';

import '../models/health.dart';
import '../models/user.dart';

class AppProvider with ChangeNotifier {
  int frequency = 1;
  AppState _state = AppState.FETCHING_DATA;
  HealthFactory health = HealthFactory();
  List<HealthDataPoint> _healthDataList = [];
  List<AppUsageInfo> _infos = [];
  int _nofSteps = 0;

  AppState getState() {
    return _state;
  }

  Health getHealth(User user) {
    var box = Hive.box('health');

    var filtered =
        box.values.where((e) => e.username == user.username).toList();

    List<HealthSteps> steps = [];
    HealthSteps st = HealthSteps();
    st.datetime = DateTime.now().toString();
    st.value = getSteps();
    if (steps
        .where((e) => e.datetime == DateTime.now().toString())
        .toList()
        .isEmpty) {
      steps.add(st);
    }

    List<HealthCalories> calories = [];
    for (var element in _healthDataList) {
      if (element.unit == HealthDataUnit.CALORIES) {
        HealthCalories cl = HealthCalories();
        cl.datetime = element.dateFrom.toString();
        cl.value = getTotalAppUsage();
        var filtered = calories
            .where((e) => e.datetime == element.dateFrom.toString())
            .toList();
        if (filtered.isEmpty) {
          calories.add(cl);
        }
      }
    }

    List<HealthSleep> sleep = [];
    for (var element in _healthDataList) {
      if (element.type == HealthDataType.SLEEP_IN_BED ||
          element.type == HealthDataType.SLEEP_AWAKE ||
          element.type == HealthDataType.SLEEP_ASLEEP) {
        HealthSleep sl = HealthSleep();
        sl.datetime = element.dateFrom.toString();
        sl.value = element.value.toInt();
        var filtered = sleep
            .where((e) => e.datetime == element.dateFrom.toString())
            .toList();
        if (filtered.isEmpty) {
          sleep.add(sl);
        }
      }
    }

    List<HealthUsage> usage = [];
    for (var element in _infos) {
      HealthUsage us = HealthUsage();
      us.datetime = element.startDate.toString();
      us.value = element.usage.inHours;
      var filtered = usage
          .where((e) => e.datetime == element.startDate.toString())
          .toList();
      if (filtered.isEmpty) {
        usage.add(us);
      }
    }

    ///Data
    for (int i = 0; i < 365; i++) {
      HealthSteps st = HealthSteps();
      st.datetime = DateTime.now().subtract(Duration(days: i)).toString();
      st.value = Random().nextInt(8000);
      steps.add(st);
    }

    steps.forEach((element) {
      print('steps ${element.datetime} => ${element.value}');
    });
    print('#############################');

    for (int i = 0; i < 365; i++) {
      HealthUsage us = HealthUsage();
      us.datetime = DateTime.now().subtract(Duration(days: i)).toString();
      us.value = Random().nextInt(10);
      usage.add(us);
    }

    usage.forEach((element) {
      print('usage ${element.datetime} => ${element.value}');
    });
    print('#############################');

    for (int i = 0; i < 365; i++) {
      HealthSleep sl = HealthSleep();
      sl.datetime = DateTime.now().subtract(Duration(days: i)).toString();
      sl.value = Random().nextInt(8);
      sleep.add(sl);
    }

    sleep.forEach((element) {
      print('sleep ${element.datetime} => ${element.value}');
    });
    print('#############################');

    for (int i = 0; i < 365; i++) {
      HealthCalories cl = HealthCalories();
      cl.datetime = DateTime.now().subtract(Duration(days: i)).toString();
      cl.value = Random().nextInt(2000);
      calories.add(cl);
    }

    calories.forEach((element) {
      print('calories ${element.datetime} => ${element.value}');
    });
    print('#############################');

    if (filtered.isNotEmpty) {
      Health p = filtered[0];
      p.totalAppUsage =
          getTotalAppUsage() == 0 ? Random().nextInt(20) : getTotalAppUsage();
      p.totalSleepTime =
          getTotalSleepTime() == 0 ? Random().nextInt(8) : getTotalSleepTime();
      p.totalCalories =
          getTotalCalories() == 0 ? Random().nextInt(3000) : getTotalCalories();
      p.totalSteps = getSteps() == 0 ? Random().nextInt(8000) : getSteps();
      p.steps.addAll(steps);
      p.calories.addAll(calories);
      p.sleep.addAll(sleep);
      p.usage.addAll(usage);
      p.save();
      return p;
    } else {
      Health p = Health()
        ..username = user.username
        ..totalAppUsage = getTotalAppUsage()
        ..totalSleepTime = getTotalSleepTime()
        ..totalCalories = getTotalCalories()
        ..totalSteps = getSteps()
        ..steps.addAll(steps)
        ..calories.addAll(calories)
        ..sleep.addAll(sleep)
        ..usage.addAll(usage);
      box.add(p);
      return p;
    }
  }

  int getSteps() {
    return _nofSteps;
  }

  int getTotalAppUsage() {
    int data = 0;
    for (var element in _infos) {
      data = data + element.usage.inHours;
    }
    return data;
  }

  int getTotalCalories() {
    int data = 0;
    for (var element in _healthDataList) {
      if (element.unit == HealthDataUnit.CALORIES) {
        data = data + element.value.toInt();
      }
    }
    return data;
  }

  int getTotalSleepTime() {
    int data = 0;
    for (var element in _healthDataList) {
      if (element.type == HealthDataType.SLEEP_IN_BED ||
          element.type == HealthDataType.SLEEP_AWAKE ||
          element.type == HealthDataType.SLEEP_ASLEEP) {
        data = data + element.value.toInt();
      }
    }
    return data;
  }

  List<AppUsageInfo> getUsage() {
    return _infos;
  }

  List<HealthDataPoint> getHealthData() {
    return _healthDataList;
  }

  Future fetchStepData() async {
    _state = AppState.FETCHING_DATA;
    final now = DateTime.now();
    final past = DateTime(now.year, now.month, now.day - 1);
    int? steps;

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      steps = await health.getTotalStepsInInterval(past, now);
      _nofSteps = (steps == null) ? 0 : steps;
      _state = AppState.DATA_READY;
    } else {
      _state = AppState.DATA_NOT_FETCHED;
    }
    print('STATE#fetchStepData $_state');
    notifyListeners();
  }

  Future fetchData() async {
    _state = AppState.FETCHING_DATA;

    final types = [
      HealthDataType.STEPS,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BLOOD_OXYGEN,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.BODY_TEMPERATURE,
      HealthDataType.HEART_RATE,
      HealthDataType.MOVE_MINUTES,
      HealthDataType.DISTANCE_DELTA,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_AWAKE,
    ];

    final permissions = [
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final past = now.subtract(Duration(days: frequency));

    bool requested =
        await health.requestAuthorization(types, permissions: permissions);

    if (requested) {
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(past, now, types);

      _healthDataList.addAll(healthData);

      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
      _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
    } else {
      _state = AppState.DATA_NOT_FETCHED;
    }
    print('STATE#fetchStepData $_state');
    notifyListeners();
  }

  Future addData() async {
    double _mgdl = 100.0;
    final now = DateTime.now();
    final earlier = now.subtract(const Duration(days: 1));

    _nofSteps = Random().nextInt(8000);
    final types = [HealthDataType.STEPS, HealthDataType.BLOOD_GLUCOSE];
    final rights = [HealthDataAccess.WRITE, HealthDataAccess.WRITE];
    final permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE
    ];
    bool? hasPermissions =
        await HealthFactory.hasPermissions(types, permissions: rights);
    if (hasPermissions == false) {
      await health.requestAuthorization(types, permissions: permissions);
    }

    bool success = await health.writeHealthData(
        _nofSteps.toDouble(), HealthDataType.STEPS, earlier, now);

    if (success) {
      success = await health.writeHealthData(
          _mgdl, HealthDataType.ACTIVE_ENERGY_BURNED, earlier, now);
    }

    _state = success ? AppState.DATA_ADDED : AppState.DATA_NOT_ADDED;
    print('STATE#addData $_state');
    notifyListeners();
  }

  Future getUsageStats() async {
    _state = AppState.FETCHING_DATA;
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: frequency));
    List<AppUsageInfo> infoList =
        await AppUsage.getAppUsage(startDate, endDate);
    _infos = infoList;
    _state = AppState.DATA_READY;
    print('STATE#getUsageStats $_state');
    notifyListeners();
  }
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  NO_DATA,
  DATA_READY,
  DATA_ADDED,
  DATA_NOT_ADDED
}
