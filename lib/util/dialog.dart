import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../providers/user_provider.dart';
import 'colors.dart';

class HealthDialog {
  static void showDialog({
    required BuildContext context,
    required String title,
    required String desc,
    dynamic Function()? onAction,
    DialogType dialogType = DialogType.ERROR,
  }) {
    Size size = MediaQuery.of(context).size;
    SchedulerBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        AwesomeDialog(
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          context: context,
          dialogType: dialogType,
          animType: AnimType.BOTTOMSLIDE,
          title: title,
          titleTextStyle: const TextStyle(color: kBlue,fontSize: 24),
          descTextStyle: const TextStyle(fontSize: 14,color: Colors.black),
          desc: desc,
          btnOkColor: const Color.fromARGB(255, 255, 177, 41),
          btnOkOnPress: onAction ?? (){},
        ).show();
      },
    );
  }
}
