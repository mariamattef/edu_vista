import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CertificateWidget extends StatelessWidget {
  const CertificateWidget({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: ColorUtility.grayLight,
      backgroundColor: ColorUtility.gbScaffold,
      // elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Certificate of Completion',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff202244),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'This Certifies that',
                style: TextStyle(
                  fontSize: 10,
                  color: ColorUtility.lightBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${FirebaseAuth.instance.currentUser?.displayName!.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorUtility.main,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Has Successfully Completed the Course',
                style: TextStyle(
                  fontSize: 9.02,
                  color: ColorUtility.lightBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Issued on ${(DateTime.now())}',
                style: const TextStyle(
                  fontSize: 9.02,
                  color: ColorUtility.main,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'ID: ${course.id}',
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 9.02,
                  color: ColorUtility.main,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course.instructor?.name ?? 'No Name',
                style: const TextStyle(
                  fontSize: 16.66,
                  color: ColorUtility.main,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Virginia M. Patterso',
                style: TextStyle(
                  fontFamily: 'PlaywriteCU',
                  fontSize: 17.35,
                  color: ColorUtility.deepYellow,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Virginia M. Patterso',
                style: TextStyle(
                  fontSize: 11.11,
                  color: ColorUtility.main,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Issued on ${(DateTime.now())}',
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 9.02,
                  color: ColorUtility.main,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
