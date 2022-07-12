import 'package:flutter/material.dart';
import 'package:healthapp/components/button_padding.dart';
import 'package:provider/provider.dart';

import '../models/health.dart';
import '../providers/app_provider.dart';

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
    var provider = context.watch<AppProvider>();
    var state = provider.isLoading;
    print('state### $state');
    return HealthButtonPadding(
      alignment: alignment,
      child: buildBody(size, state),
    );
  }

  Widget buildBody(Size size, bool state) {
    return RaisedButton(
      onPressed: text == 'LOGIN'
          ? state ==false
              ? onPressed
              : null
          : onPressed,
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
        child: text == 'LOGIN'
            ? state ==false
                ? Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : const Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator()),
                  )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
