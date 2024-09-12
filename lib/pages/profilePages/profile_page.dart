import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/pages/card_page.dart';
import 'package:edu_vista/pages/profilePages/edit_profile_page.dart';
import 'package:edu_vista/pages/profilePages/settings_profile_page.dart';
import 'package:edu_vista/widgets/Custom_text_button.dart';
import 'package:edu_vista/widgets/profile/profile_menu_widget.dart';
import 'package:edu_vista/widgets/profile/proflle_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  static const String id = 'ProfilePage';
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text("Profile"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartPage.id);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePicWidget(),
            const SizedBox(height: 120),
            ProfileMenu(
              text: "Edit",
              press: () => {
                Navigator.pushNamed(context, EditProfilePage.id),
              },
            ),
            ProfileMenu(
              text: "Setting ",
              press: () {
                Navigator.pushNamed(context, SettingsProfilePage.id);
              },
            ),
            ProfileMenu(
              text: "About Us",
              press: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextButton(
                    label: "Logout",
                    onPressed: () async {
                      await context.read<AuthCubit>().signOut(context);
                    },
                    // ignore: prefer_const_constructors
                    color: Color(0xFFEA4335),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
