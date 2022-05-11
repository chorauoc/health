import 'package:flutter/material.dart';
import 'package:healthapp/util/colors.dart';

class HealthHeading extends StatelessWidget {
  final String text;
  const HealthHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kBlue,
        fontSize: 36,
      ),
      textAlign: TextAlign.left,
    );
  }
}
