import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/all_categories_page.dart';
import 'package:edu_vista/pages/card_page.dart';
import 'package:edu_vista/pages/category_course_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/widdgits/categories_widget.dart';
import 'package:edu_vista/widgets/courses_widget.dart';
import 'package:edu_vista/widgets/label_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeServiceWidget extends StatefulWidget {
  List<Course>? courses;
  HomeServiceWidget({this.courses, super.key});

  @override
  State<HomeServiceWidget> createState() => _HomeServiceWidgetState();
}

class _HomeServiceWidgetState extends State<HomeServiceWidget> {
  bool showAllCourses = false;
  void toggleShowAllCourses() {
    setState(() {
      showAllCourses = !showAllCourses;
    });
  }

  @override
  void initState() {
    // context.read<AuthCubit>().checkUserStatus();
    // if (!showAllCourses) {
    //   widget.courses = widget.courses?.take(2).toList();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Welcome Back!  ',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              TextSpan(
                text: '${FirebaseAuth.instance.currentUser?.displayName}',
                style: const TextStyle(
                    color: ColorUtility.main,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PlusJakartaSans'), // Set color to yellow
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartPage.id);
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LabelWidget(
                  name: 'Categories',
                  onSeeAllClicked: () {
                    Navigator.pushNamed(context, AllCategoryPage.id);
                  },
                ),
                const CategoriesWidget(),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Rated',
                  onSeeAllClicked: () {
                    // toggleShowAllCourses();
                    showAllCourses = !showAllCourses;
                    setState(() {});
                  },
                ),
                CoursesWidget(
                  futureCall: FirebaseFirestore.instance
                      .collection('courses')
                      .where('rank', isEqualTo: 'top rated')
                      .orderBy('created_date', descending: true)
                      .get(),
                  rankValue: 'top rated',
                ),
                LabelWidget(
                  name: 'Top Seller',
                  onSeeAllClicked: () {
                    toggleShowAllCourses();
                  },
                ),
                CoursesWidget(
                  futureCall: FirebaseFirestore.instance
                      .collection('courses')
                      .where('rank', isEqualTo: 'top seller')
                      .orderBy('created_date', descending: true)
                      .get(),
                  rankValue: 'top seller',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edu_vista/pages/card_page.dart';
// import 'package:edu_vista/pages/test2_page.dart';
// import 'package:edu_vista/utils/color_utilis.dart';
// import 'package:edu_vista/widgets/categories_widget.dart';
// import 'package:edu_vista/widgets/courses_widget.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   static const String id = 'home';
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? rankValue;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // bottomNavigationBar: BottomNavigationBarExample(),
//       appBar: AppBar(
//         title: RichText(
//           text: TextSpan(
//             children: [
//               const TextSpan(
//                 text: 'Welcome Back!  ',
//                 style: TextStyle(color: Colors.black, fontSize: 20),
//               ),
//               TextSpan(
//                 text: '${FirebaseAuth.instance.currentUser?.displayName}',
//                 style: const TextStyle(
//                     color: ColorUtility.main,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w700,
//                     fontFamily: 'PlusJakartaSans'), // Set color to yellow
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, CartPage.id);
//             },
//             icon: const Icon(
//               Icons.shopping_cart_outlined,
//               size: 30,
//             ),
//           ),
//         ],
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, CategoryExpansionPanelPage.id);
//         },
//         backgroundColor: ColorUtility.main,
//         child: const Icon(Icons.search),
//       ),

//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               CategoriesWidget(),
//               Expanded(
//                 child: ListView(children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const CoursesWidget(
//                     name: 'Students Also Search for',
//                     rankValue: '',
//                     futureCall: null,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   CoursesWidget(
//                       name: 'Top Rated Courses',
//                       rankValue: 'top rated',
//                       futureCall: FirebaseFirestore.instance
//                           .collection('courses')
//                           .where('rank', isEqualTo: widget.rankValue)
//                           .orderBy('created_date', descending: true)
//                           .get()),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // SizedBox(
//                   //   height: 20,
//                   // ),
//                   CoursesWidget(
//                     futureCall: FirebaseFirestore.instance
//                         .collection('courses')
//                         .where('rank', isEqualTo: 'top seller')
//                         .orderBy('created_date', descending: true)
//                         .get(),
//                     name: 'Top Seller Courses',
//                     rankValue: 'top seller',
//                   ),
//                 ]),
//               ),
//               // TabBarExample()
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: BottomNavPage(),
//     );
//   }
// }
