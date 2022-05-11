import 'package:flutter/material.dart';
import 'package:healthapp/components/animated_indicator.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/util/colors.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HealthChartFilter extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const HealthChartFilter({Key? key, this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ),
          elevation: 2,
          shadowColor: kBlue,
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
