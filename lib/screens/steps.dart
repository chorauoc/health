import 'package:flutter/material.dart';
import 'package:healthapp/screens/chart.dart';

import '../models/chart_data.dart';
import '../models/health.dart';

class StepsScreen extends StatelessWidget {
  final double value;
  final List<HealthSteps> usage;
  const StepsScreen({Key? key, required this.value, required this.usage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatrData> data = [];
    for (var element in usage) {
      data.add(ChatrData(DateTime.parse(element.datetime!), element.value));
    }
    return ChartScreen(
      title: 'Steps',
      value: value,
      data: data,
    );
  }
}
