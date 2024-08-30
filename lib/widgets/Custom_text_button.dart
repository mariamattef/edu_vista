import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String label;
  Color? color;
  void Function()? onPressed;
  CustomTextButton(
      {required this.label,
      this.color = ColorUtility.deepYellow,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
          onTap: onPressed,
          child: Text(
            label,
            style: TextStyle(color: color ?? Color(0xFFEA4335), fontSize: 20),
          )),
    );
  }
}
