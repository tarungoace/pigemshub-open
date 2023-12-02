import 'package:flutter/material.dart';

import '../../constants/colors_value.dart';

class PiButton extends StatelessWidget {
  const PiButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.buttonHeight = 59,
    this.buttonWidth = double.infinity,
    this.buttonContainerColor = Colors.blue,
    this.buttonRadius = 15,
    this.child,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonContainerColor;
  final double buttonRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      disabledColor: Colors.black12,
      onPressed: onPressed,
      height: buttonHeight,
      minWidth: buttonWidth,
      color: ColorsValue.primaryColor(context),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonRadius),
      ),
      child: child ?? Text(title, style: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }
}
