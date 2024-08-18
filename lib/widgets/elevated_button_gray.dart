import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ElevatedButtonGray extends StatelessWidget {
  void Function() onPressed;
  final String label;

  Size? fixedSize;
  ElevatedButtonGray(
      {required this.onPressed,
      required this.label,
      this.fixedSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: ColorUtility.buttonGray,
        ),
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
    );
  }
}
