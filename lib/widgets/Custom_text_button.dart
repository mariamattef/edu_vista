import 'package:edu_vista/constants.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String label;
  void Function()? onPressed;
  CustomTextButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
          style: const ButtonStyle(alignment: Alignment.centerRight),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(color: KyellowColor, fontSize: 20),
          )),
    );
  }
}
