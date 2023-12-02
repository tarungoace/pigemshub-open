import 'package:flutter/material.dart';
import 'package:pigemshubshop/app/common/widgets/pi_button.dart';

import '../../constants/colors_value.dart';

class ErrorCommonDialog {

  static show(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent.withOpacity(.5),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          contentPadding: const EdgeInsets.all(20),
          content: Text(message),
          actions: <Widget>[
            PiButton(
              title: "Okay",
              buttonHeight: 40,
              buttonWidth: double.infinity,
              buttonContainerColor: Colors.blue,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

}
