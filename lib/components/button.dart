import 'package:flutter/material.dart';
import 'package:healthapp/components/button_padding.dart';

class HealthButton extends StatelessWidget {
  final String text;
  final AlignmentGeometry? alignment;
  final void Function() onPressed;

  const HealthButton(
      {Key? key, required this.text, required this.onPressed, this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return HealthButtonPadding(
      alignment: alignment,
      child: buildBody(size),
    );
  }

  Widget buildBody(Size size) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      textColor: Colors.white,
      padding: const EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 255, 136, 34),
              Color.fromARGB(255, 255, 177, 41)
            ])),
        padding: const EdgeInsets.all(0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
