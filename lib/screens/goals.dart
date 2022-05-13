import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/spacer.dart';

import '../components/button.dart';
import '../components/text_form_feild.dart';
import '../main.dart';
import '../models/goal.dart';
import '../models/user.dart';
import '../providers/goal_provider.dart';
import '../providers/user_provider.dart';
import '../util/dialog.dart';
import 'dashboard.dart';

class GoalsScreen extends StatelessWidget {
  GoalsScreen({Key? key}) : super(key: key);
  User? user;
  Goal? goal;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController sleepGoalController = TextEditingController();
  final TextEditingController activityGoalController = TextEditingController();
  final TextEditingController screenTimeController = TextEditingController();
  final TextEditingController stepsGoalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = locator<UserProvider>().getSession();
    goal = locator<GoalProvider>().getGoals();
    sleepGoalController.text = goal?.sleepGoal ?? '';
    activityGoalController.text = goal?.activityGoal ?? '';
    screenTimeController.text = goal?.screenTime ?? '';
    stepsGoalController.text = goal?.stepsGoal ?? '';

    return Scaffold(
      body: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const HealthAppBar(
              title: 'Daily Goals',
              isBack: true,
            ),
            const HealthSpacer(height: 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const HealthSpacer(height: 0.03),
                      HealthTextFormFeild(
                        controller: sleepGoalController,
                        text: 'Sleep Goal (Hrs)',
                        placeholder: getSleepHelperText(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                      const HealthSpacer(height: 0.03),
                      HealthTextFormFeild(
                        controller: activityGoalController,
                        text: 'Activity Goal (Cal)',
                        placeholder: getCalHelperText(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                      const HealthSpacer(height: 0.03),
                      HealthTextFormFeild(
                        controller: screenTimeController,
                        text: 'Screen Time Goal (Hrs)',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                      const HealthSpacer(height: 0.05),
                      HealthTextFormFeild(
                        controller: stepsGoalController,
                        text: 'Steps Goal (Steps)',
                        placeholder: getStepsHelperText(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                      const HealthSpacer(height: 0.05),
                      HealthButton(
                        text: 'SET UP',
                        alignment: Alignment.center,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var update = Goal()
                              ..username = user?.username
                              ..stepsGoal = stepsGoalController.text
                              ..sleepGoal = sleepGoalController.text
                              ..screenTime = screenTimeController.text
                              ..activityGoal = activityGoalController.text;

                            GoalState result =
                                locator<GoalProvider>().update(update);

                            if (result == GoalState.completed) {
                              HealthDialog.showDialog(
                                  context: context,
                                  title: 'Daily Goals',
                                  desc: 'Daily Goals setup was successful',
                                  dialogType: DialogType.SUCCES,
                                  onAction: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardScreen()));
                                  });
                            } else {
                              HealthDialog.showDialog(
                                context: context,
                                title: 'Daily Goals',
                                desc: 'Daily Goals setup was unsuccessful',
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? getCalHelperText() {
    if (user == null) {
      return null;
    } else {
      var gender = user?.gender;
      if (gender == 'Male') {
        return 'More than 2500kal is suggest for you';
      }  else {
        return 'More than 2000kal is suggest for you';
      }
    }
  }

  String? getStepsHelperText() {
    if (user == null) {
      return null;
    } else {
      var age = int.parse(user!.age!);
      if (age > 12 && age < 18) {
        return '6000 – 10000 steps is suggest for you';
      } else if (age > 18 && age < 65) {
        return '7000 – 10000 steps is suggest for you';
      } else {
        return '3000 – 10000 steps is suggest for you';
      }
    }
  }

  String? getSleepHelperText() {
    if (user == null) {
      return null;
    } else {
      var age = int.parse(user!.age!);
      if (age > 12 && age < 18) {
        return '8-10 hours sleep is suggest for you';
      } else if (age > 18 && age < 60) {
        return '7 or more hours sleep is suggest for you';
      } else {
        return null;
      }
    }
  }
}
