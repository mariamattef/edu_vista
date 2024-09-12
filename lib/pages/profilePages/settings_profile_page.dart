import 'package:edu_vista/widgets/profile_menu_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsProfilePage extends StatelessWidget {
  static const id = 'ProfileSettingsPage';
  const SettingsProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text("Account Settings",
                    style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  "Update your settings like notifications, payments, profile edit etc.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ProfileMenuCard(
                  svgSrc: 'assets/images/profile.svg',
                  title: "Profile Information",
                  subTitle: "Change your account information",
                  press: () {},
                ),
                ProfileMenuCard(
                  svgSrc: 'assets/images/lock.svg',
                  title: "Change Password",
                  subTitle: "Change your password",
                  press: () {},
                ),
                ProfileMenuCard(
                  svgSrc: 'assets/images/iconmonstr-credit-card-thin.svg',
                  title: "Payment Methods",
                  subTitle: "Add your credit & debit cards",
                  press: () {},
                ),
                ProfileMenuCard(
                  svgSrc: 'assets/images/iconmonstr-credit-card-thin.svg',
                  title: "Locations",
                  subTitle: "Add or remove your delivery locations",
                  press: () {},
                ),
                ProfileMenuCard(
                  svgSrc: 'assets/images/iconmonstr-credit-card-thin.svg',
                  title: "Add Social Account",
                  subTitle: "Add Facebook, Twitter etc ",
                  press: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
