import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  UserState _result = UserState.loading;
  User? _session;

  UserState add(User user) {
    var box = Hive.box('app');

    var filteredUsers =
    box.values.where((e) => e.username == user.username).toList();

    if (filteredUsers.isNotEmpty) {
      _result = UserState.exsist;
    } else {
      box.add(user);
      _result = UserState.completed;
    }

    return _result;
  }

  UserState update(User user) {
    var box = Hive.box('app');

    var filteredUsers =
    box.values.where((e) => e.username == user.username).toList();

    if (filteredUsers.isNotEmpty) {
      User p = filteredUsers[0];
      p.name = user.name;
      p.email = user.email;
      p.password = user.password;
      p.username = user.username;
      p.hasPlaner = user.hasPlaner;
      p.save();
      _result = UserState.completed;
    }

    return _result;
  }

  UserState check(User user) {
    var box = Hive.box('app');

    var filteredUsers =
    box.values.where((e) => e.username == user.username).toList();

    if (filteredUsers.isNotEmpty) {
      if (filteredUsers[0].password == user.password) {
        _session = filteredUsers[0];
        _result = UserState.completed;
      } else {
        _result = UserState.incorrectUserCredentials;
      }
    } else {
      _result = UserState.notExsist;
    }

    return _result;
  }

  UserState getResult() {
    return _result;
  }

  User? getSession() {
    return _session;
  }

  void reset() {
    _result = UserState.loading;
    _session = null;
  }

  void notify() {
    notifyListeners();
  }
}

enum UserState {
  loading,
  completed,
  error,
  exsist,
  notExsist,
  incorrectUserCredentials
}
