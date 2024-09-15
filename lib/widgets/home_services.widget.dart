import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/cart_page/shop_items_page.dart';
import 'package:edu_vista/pages/generalPage/all_categories_page.dart';
import 'package:edu_vista/pages/cart_page/card_page.dart';
import 'package:edu_vista/pages/generalPage/category_course_page.dart';
import 'package:edu_vista/pages/generalPage/payment_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/widdgits/categories_widget.dart';
import 'package:edu_vista/widgets/courses_widget.dart';
import 'package:edu_vista/widgets/label_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceWidget extends StatefulWidget {
  List<Course>? courses;
  HomeServiceWidget({this.courses, super.key});

  @override
  State<HomeServiceWidget> createState() => _HomeServiceWidgetState();
}

class _HomeServiceWidgetState extends State<HomeServiceWidget> {
  bool showAllTopRated = false;
  bool showAllTopSeller = false;

  void toggleShowAllTopRated() {
    setState(() {
      showAllTopRated = !showAllTopRated;
    });
  }

  void toggleShowAllTopSeller() {
    setState(() {
      showAllTopSeller = !showAllTopSeller;
    });
  }

  int count = 0;

  @override
  void initState() {
    super.initState();
    // context.read<AuthCubit>().checkUserStatus();
    // if (!showAllCourses) {
    //   widget.courses = widget.courses?.take(2).toList();
    // }
    context.read<AuthCubit>().userLoginOrNot();
    init();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      count = await context.read<AuthCubit>().getCollectionCount('courses');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, State) {
                if (State is NewUser) {
                  return const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                } else if (State is OldUser) {
                  return const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.displayName?.toUpperCase() ?? 'User'.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ColorUtility.main),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ShopItemsPage.id);
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Navigator.pushNamed(context, PaymentPage.id);
      // }),
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
                CategoriesWidget(),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Rated',
                  onSeeAllClicked: toggleShowAllTopRated,
                ),
                CoursesWidget(
                  futureCall: FirebaseFirestore.instance
                      .collection('courses')
                      .where('rank', isEqualTo: 'top rated')
                      .limit(showAllTopRated ? count : 2)
                      .orderBy('created_date', descending: true)
                      .get(),
                  rankValue: 'top rated',
                ),
                LabelWidget(
                  name: 'Top Seller',
                  onSeeAllClicked: toggleShowAllTopSeller,
                ),
                CoursesWidget(
                  futureCall: FirebaseFirestore.instance
                      .collection('courses')
                      .where('rank', isEqualTo: 'top seller')
                      .limit(showAllTopSeller ? count : 2)
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
