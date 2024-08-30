import 'package:edu_vista/pages/botton_nav_page.dart';
import 'package:edu_vista/pages/home_page.dart';
import 'package:edu_vista/pages/login_page.dart';
import 'package:edu_vista/pages/onboarding_page.dart';
import 'package:edu_vista/services/pref.service.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static String id = 'SplashPage';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageUtility.logo,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void _startApp() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      if (PreferencesService.isOnBoardingSeen) {
        // Navigator.pushReplacementNamed(context, LoginPage.id);

        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushReplacementNamed(context, BottomNavPage.id);
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.id);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingpage.id);
      }
    }
  }
}
