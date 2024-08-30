import 'package:edu_vista/pages/categories_page.dart';
import 'package:edu_vista/pages/home_page.dart';
import 'package:edu_vista/pages/profile_page.dart';
import 'package:edu_vista/pages/test_screen.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class BottomNavPage extends StatefulWidget {
  static const String id = 'BottomNavPage';
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const Center(
      child: HomePage(),
    ),
    const Center(
      child: CategoriesPage(),
    ),
    const Center(
      child: AudioCallingScreen(),
    ),
    const Center(
      child: ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorUtility.gbScaffold,
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        // showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_max_outlined),
              activeIcon: Icon(
                Icons.home,
                color: ColorUtility.deepYellow,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: inActiveIconColor,
              ),
              label: 'fav'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: inActiveIconColor,
              ),
              label: 'Chat'),
          const BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGKbfv6axBJugPvg8wk8MbIg00xks4soLvLa4d4dNIgw-jPdT7z1RV_HX1kpyt0_oDO1g&usqp=CAU"),
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
