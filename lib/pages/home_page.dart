import 'package:edu_vista/pages/Course_Page.dart';
import 'package:edu_vista/pages/chatPages/chat_page.dart';
import 'package:edu_vista/pages/profilePages/profile_page.dart';
import 'package:edu_vista/pages/search_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/home_services.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeServiceWidget();
      case 1:
        return const CoursesPage();
      case 2:
        return const SearchPage();
      case 3:
        return const ChatsPage();
      case 4:
        return const ProfilePage();
      default:
        return HomeServiceWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorUtility.gbScaffold,
        selectedItemColor: ColorUtility.deepYellow,
        unselectedItemColor: Color(0xff1D1B20),
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),

          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGKbfv6axBJugPvg8wk8MbIg00xks4soLvLa4d4dNIgw-jPdT7z1RV_HX1kpyt0_oDO1g&usqp=CAU"),
              ),
              label: 'Profile'),

          // icon: CircleAvatar(
          //   backgroundImage: FirebaseAuth.instance.currentUser?.photoURL !=
          //               null &&
          //           FirebaseAuth.instance.currentUser!.photoURL!.isNotEmpty
          //       ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
          //       : const AssetImage(ImageUtility.userProfile),
          // ),
        ],
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
//                   const CoursesWidget(
//                     name: 'Top Rated Courses',
//                     rankValue: 'top rated',
//                     futureCall: null,
//                   ),
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
