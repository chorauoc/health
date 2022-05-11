import 'package:flutter/material.dart';
import 'package:healthapp/components/animated_indicator.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/util/colors.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HealthLinearCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double value;
  final void Function()? onTap;
  const HealthLinearCard(
      {Key? key,
      required this.title,
      required this.value,
      this.subtitle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: LinearPercentIndicator(
                width: size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: value,
                animateFromLastPercent: true,
                center: Text("${value * 100}%"),
                isRTL: false,
                barRadius: const Radius.elliptical(15, 15),
                progressColor: Colors.orangeAccent,
                maskFilter: const MaskFilter.blur(BlurStyle.solid, 3),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            HealthSpacer(height: 0.01)
          ],
        ),
        elevation: 2,
        shadowColor: kBlue,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
