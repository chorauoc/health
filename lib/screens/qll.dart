import 'package:flutter/material.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/linear_card.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/util/colors.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../models/health.dart';
import '../models/user.dart';
import '../providers/app_provider.dart';
import '../providers/goal_provider.dart';
import '../providers/user_provider.dart';
import '../util/calculation.dart';

class QLLScreen extends StatelessWidget {
  QLLScreen({Key? key}) : super(key: key);

  User? user;
  Health? health;
  Goal? goal;

  @override
  Widget build(BuildContext context) {
    user = context.select((UserProvider p) => p.getSession());
    health = context.select((AppProvider p) => p.getHealth(user!));
    goal = context.select((GoalProvider p) => p.getGoals());

    return Scaffold(
      body: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const HealthAppBar(
              title: 'Improve QOL',
              isBack: true,
            ),
            const HealthSpacer(height: 0.01),
            Expanded(
              child: health == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          buildSectionHeader('Sleep Goal'),
                          buildProgressSection(
                            '${health?.totalSleepTime}/${goal?.sleepGoal ?? '0'} Hrs',
                            HealthCalculation.calculateSleepTimeValue(health!),
                          ),
                          const HealthSpacer(height: 0.03),
                          buildSectionHeader('Activity Goal'),
                          buildProgressSection(
                            '${health?.totalCalories}/${goal?.activityGoal ?? '0'} Cal',
                            HealthCalculation.calculateAtivityValue(health!),
                          ),
                          const HealthSpacer(height: 0.03),
                          buildSectionHeader('Screen Time Goal'),
                          buildProgressSection(
                            '${health?.totalAppUsage}/${goal?.screenTime ?? '0'} Hrs',
                            HealthCalculation.calculateScreenTimeValue(health!),
                          ),
                          const HealthSpacer(height: 0.03),
                          buildSectionHeader('Steps Goal'),
                          buildProgressSection(
                            '${health?.totalSteps}/${goal?.stepsGoal ?? '0'} Steps',
                            HealthCalculation.calculateStepsValue(health!),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressSection(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HealthLinearCard(
          title: title,
          value: value,
        ),
      ],
    );
  }

  Widget buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kBlue,
              fontSize: 18,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
