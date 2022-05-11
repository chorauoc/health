import 'package:flutter/material.dart';

class HealthButtonPadding extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry? alignment;
  const HealthButtonPadding({
    Key? key,
    required this.child,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: alignment ?? Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: child,
    );
  }
}
