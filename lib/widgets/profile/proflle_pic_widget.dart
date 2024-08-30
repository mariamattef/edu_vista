import 'package:edu_vista/utils/color_utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGKbfv6axBJugPvg8wk8MbIg00xks4soLvLa4d4dNIgw-jPdT7z1RV_HX1kpyt0_oDO1g&usqp=CAU"),
          ),
          Positioned(
            top: 120,
            left: 5,
            child: Column(
              children: [
                Text(
                  '${FirebaseAuth.instance.currentUser?.displayName}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${FirebaseAuth.instance.currentUser?.email}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 44,
              width: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.topCenter,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.photo_camera_back,
                    color: Colors.grey,
                    size: 33,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
