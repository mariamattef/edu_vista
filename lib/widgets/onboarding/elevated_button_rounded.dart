import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedButtonRounded extends StatelessWidget {
  void Function()? onPressed;
  MaterialStateProperty<Color?>? backgroundColor;
  Widget? icon;

  ElevatedButtonRounded(
      {required this.onPressed,
      required this.icon,
      required this.backgroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.all(15),
        ),
        shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
