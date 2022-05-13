import 'package:flutter/material.dart';
import 'package:healthapp/util/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HealthCircularCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double value;
  final void Function()? onTap;
  const HealthCircularCard(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 15.0,
            animation: true,
            percent: value,
            center: Text(
              "${double.parse((value * 100).toString()).toStringAsFixed(2)}%",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: Column(
              children: [
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
        ),
        elevation: 2,
        shadowColor: kBlue,
        margin: const EdgeInsets.all(5),
      ),
    );
  }
}
