import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/pages/cart_page/card_page.dart';
import 'package:edu_vista/pages/profilePages/about_us_page.dart';
import 'package:edu_vista/pages/profilePages/edit_profile_page.dart';
import 'package:edu_vista/pages/profilePages/settings_profile_page.dart';
import 'package:edu_vista/pages/cart_page/shop_items_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/Custom_text_button.dart';
import 'package:edu_vista/widgets/profile/profile_menu_widget.dart';
import 'package:edu_vista/widgets/profile/proflle_pic_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'ProfilePage';
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;

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
                  Navigator.pushNamed(context, ShopItemsPage.id);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                ),
              ),
            ),
          ]),
      body: user == null
          ? const Center(
              child: Text('No Data Found'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ProfilePicWidget(),
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
                    press: () {
                      Navigator.pushNamed(context, AboutUsPage.id);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return TextButton(
                              onPressed: () => _logOutAndDeleteDialog(
                                title: 'Are you want to log out?',
                                data: 'Log Out',
                                onPressed: () async {
                                  await context
                                      .read<AuthCubit>()
                                      .logout(context);
                                },
                              ),
                              child: const Text(
                                'Log out',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _logOutAndDeleteDialog({
    required String title,
    required void Function()? onPressed,
    required String data,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  data,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
