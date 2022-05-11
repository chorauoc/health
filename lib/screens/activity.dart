import 'package:flutter/material.dart';
import 'package:healthapp/screens/chart.dart';

import '../models/chart_data.dart';
import '../models/health.dart';

class ActivityScreen extends StatelessWidget {
  final double value;
  final List<HealthCalories> usage;
  const ActivityScreen({Key? key, required this.value, required this.usage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatrData> data = [];
    for (var element in usage) {
      data.add(ChatrData(DateTime.parse(element.datetime!), element.value));
    }

    return ChartScreen(
      title: 'Activity',
      value: value,
      data: data,
    );
  }
}
