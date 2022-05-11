import 'package:flutter/material.dart';
import 'package:healthapp/components/button_padding.dart';
import 'package:healthapp/util/colors.dart';

class HealthLinkButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const HealthLinkButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return HealthButtonPadding(
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: kBlue),
        ),
      ),
    );
  }
}
