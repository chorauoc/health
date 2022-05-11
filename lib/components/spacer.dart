import 'package:flutter/material.dart';

class HealthSpacer extends StatelessWidget {
  final double height;
  const HealthSpacer({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * height);
  }
}
