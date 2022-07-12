import 'package:flutter/material.dart';
import 'package:healthapp/screens/chart.dart';

import '../models/chart_data.dart';
import '../models/health.dart';

class ScreenQOLScreen extends StatelessWidget {
  final double value;
  final List<HealthQol> usage;
  const ScreenQOLScreen({Key? key, required this.usage, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatrData> data = [];
    for (var element in usage) {
      data.add(ChatrData(DateTime.parse(element.datetime!), element.value));
    }
    return ChartScreen(
      title: 'Quality of Life',
      value: value,
      data: data,
    );
  }
}
