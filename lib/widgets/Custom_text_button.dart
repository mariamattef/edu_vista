import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String label;
  void Function()? onPressed;
  CustomTextButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
          // style: const ButtonStyle(
          //     padding: MaterialStatePropertyAll(EdgeInsets.zero),
          //     alignment: Alignment.centerRight),
          onTap: onPressed,
          child: Text(
            label,
            style:
                const TextStyle(color: ColorUtility.deepYellow, fontSize: 20),
          )),
    );
  }
}
