import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/category.dart';
import 'package:edu_vista/pages/generalPage/category_course_page.dart';
import 'package:edu_vista/pages/cart_page/shop_items_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/expansion_tile_widget.dart';
import 'package:edu_vista/widgets/courses_widget.dart';

import 'package:flutter/material.dart';

class AllCategoryPage extends StatelessWidget {
  AllCategoryPage({
    super.key,
  });

  static const String id = 'SeeAllCategoriesPage';
  bool isexpanded = false;
  bool showAllCourses = false;
  int count = 0;
  void toggleShowAllcourse() {
    showAllCourses = !showAllCourses;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Center(
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorUtility.main,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.pushNamed(context, ShopItemsPage.id);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('categories').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                log('Error fetching categories: ${snapshot.error}');
                return const Center(
                  child: Text('Error occurred'),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No categories found'),
                );
              }

              var categories = List<Category>.from(snapshot.data?.docs
                      .map((e) => Category.fromJson({'id': e.id, ...e.data()}))
                      .toList() ??
                  []);

              return Expanded(
                  child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTileWidget(
                        titleTile: categories[index].name ?? 'No Name',
                        icons: isexpanded
                            ? Icons.keyboard_double_arrow_down_outlined
                            : Icons.double_arrow_outlined,
                        body: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  toggleShowAllcourse();
                                  Navigator.pushNamed(
                                    context,
                                    CategoryCoursesPage.id,
                                    arguments: categories[index].name,
                                  );
                                },
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CoursesWidget(
                            futureCall: FirebaseFirestore.instance
                                .collection('courses')
                                .where('caregory.id',
                                    isEqualTo: categories[index].id)
                                .limit(showAllCourses ? count : 2)
                                .get(),
                          ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                        ],
                      ));
                },
              ));
            }),
      ),
    );
  }
}
