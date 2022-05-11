import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/util/colors.dart';

import '../models/plans/plans.dart';

class WorkOutPlanScreen extends StatelessWidget {
  WorkOutPlanScreen({Key? key}) : super(key: key);
  List<Widget> plans = [
    plan1,
    plan2,
    plan3,
    plan4,
    plan5,
    plan6,
    plan7,
    plan8,
    plan9,
    plan10
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const HealthAppBar(
              title: 'Workout Plans',
              isBack: true,
            ),
            const HealthSpacer(height: 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'How it Works',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kBlue,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const HealthSpacer(height: 0.03),
                      const Text(
                        'Health pro is dedicated to make your lifestyle more healthier. By monthly analysis of the steps and activities conducted every day, you are provided with the option of obtaining a customised workout plan based on the previously stored health data .',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const HealthSpacer(height: 0.03),
                      plans[Random().nextInt(plans.length)],
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
}
