import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
    required this.iconData,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: const EdgeInsets.only(right: 20, top: 15, bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: ColorUtility.grayExtraLight,
        ),
        onPressed: press,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              iconData,
              color: Colors.black,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
