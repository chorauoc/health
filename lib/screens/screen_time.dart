import 'package:flutter/material.dart';
import 'package:healthapp/screens/chart.dart';

import '../models/chart_data.dart';
import '../models/health.dart';

class ScreenTimeScreen extends StatelessWidget {
  final double value;
  final List<HealthUsage> usage;
  const ScreenTimeScreen({Key? key, required this.usage, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatrData> data = [];
    for (var element in usage) {
      data.add(ChatrData(DateTime.parse(element.datetime!), element.value));
    }
    return ChartScreen(
      title: 'Screen Time',
      value: value,
      data: data,
    );
  }
}
