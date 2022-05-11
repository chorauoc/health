import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:healthapp/models/chart_data.dart';

class HealthBarChart extends StatelessWidget {
  final List<charts.Series<ChatrData, String>> seriesList;
  final bool animate;

  const HealthBarChart(
      {Key? key, required this.seriesList, this.animate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: const charts.OrdinalAxisSpec(),
    );
  }
}
