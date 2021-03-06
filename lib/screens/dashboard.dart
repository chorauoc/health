import 'package:flutter/material.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/circular_card.dart';
import 'package:healthapp/components/drawer.dart';
import 'package:healthapp/components/linear_card.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/providers/app_provider.dart';
import 'package:healthapp/screens/activity.dart';
import 'package:healthapp/screens/screen_qol.dart';
import 'package:healthapp/screens/screen_time.dart';
import 'package:healthapp/screens/sleep_time.dart';
import 'package:healthapp/screens/steps.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../models/health.dart';
import '../models/user.dart';
import '../providers/goal_provider.dart';
import '../providers/user_provider.dart';
import '../util/calculation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? user;
  Health? health;
  Goal? goal;


  @override
  void initState() {
    //_init();
    super.initState();
  }

  void _init() async {
    // await locator<AppProvider>().addData();
    await locator<AppProvider>().fetchData();
    await locator<AppProvider>().fetchStepData();
    await locator<AppProvider>().getUsageStats();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    user = context.select((UserProvider p) => p.getSession());
    if(user!=null){
      health = context.select((AppProvider p) => p.getHealth(user!));
    }
    goal = context.select((GoalProvider p) => p.getGoals());

    return Scaffold(
      body: health == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Background(
              isAppBar: true,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const HealthAppBar(
                    title: 'Dashboard',
                  ),
                  const HealthSpacer(height: 0.03),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HealthLinearCard(
                              title: 'Quality of Life',
                              value: HealthCalculation
                                  .calculateQualityOfLifeValue(health!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenQOLScreen(
                                      value: HealthCalculation
                                          .calculateQualityOfLifeValue(health!),
                                      usage: health?.qol ?? [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HealthCircularCard(
                              title: 'Screen Time',
                              subtitle:
                                  '${health?.totalAppUsage.toString()} Hrs',
                              value:
                                  HealthCalculation.calculateScreenTimeValue(health!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenTimeScreen(
                                      value: HealthCalculation
                                          .calculateScreenTimeValue(health!),
                                      usage: health?.usage ?? [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            HealthCircularCard(
                              title: 'Sleep Time',
                              subtitle:
                                  '${health?.totalSleepTime.toString()} Hrs',
                              value:
                                  HealthCalculation.calculateSleepTimeValue(health!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SleepTimeScreen(
                                      value: HealthCalculation
                                          .calculateSleepTimeValue(health!),
                                      usage: health?.sleep ?? [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HealthCircularCard(
                              title: 'Steps',
                              subtitle: health?.totalSteps.toString(),
                              value: HealthCalculation.calculateStepsValue(health!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StepsScreen(
                                      value: HealthCalculation
                                          .calculateStepsValue(health!),
                                      usage: health?.steps ?? [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            HealthCircularCard(
                              title: 'Activity',
                              subtitle:
                                  '${health?.totalCalories.toString()} cal',
                              value: HealthCalculation.calculateAtivityValue(health!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActivityScreen(
                                      value: HealthCalculation
                                          .calculateAtivityValue(health!),
                                      usage: health?.calories ?? [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const HealthSpacer(height: 0.03),
                      ],
                    ),
                  ))
                ],
              ),
            ),
      drawer: const HealthDrawer(),
    );
  }
}
