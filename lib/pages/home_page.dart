import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/categories_widget.dart';
import 'package:edu_vista/widgets/courses_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBarExample(),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Welcome Back!  ',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              TextSpan(
                text: '${FirebaseAuth.instance.currentUser?.displayName}',
                style: TextStyle(
                    color: ColorUtility.main,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PlusJakartaSans'), // Set color to yellow
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, Test2Page.id);
      //   },
      //   child: Icon(Icons.search),
      //   backgroundColor: ColorUtility.main,
      // ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CategoriesWidget(),
              Expanded(
                child: ListView(children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CoursesWidget(
                    name: 'Students Also Search for',
                    rankValue: '',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CoursesWidget(
                    name: 'Top Rated Courses',
                    rankValue: 'top rated',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CoursesWidget(
                    name: 'Top Seller Courses',
                    rankValue: 'top seller',
                  ),
                ]),
              ),
              // TabBarExample()
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavPage(),
    );
  }
}
