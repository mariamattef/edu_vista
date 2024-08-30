import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/category.dart';
import 'package:edu_vista/pages/categories_page.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  List<Category>? categories;
  CategoriesWidget({this.categories, super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  bool showAndHide = false;
  List<Category>? categories;
  void toggleShowAllCategory() {
    setState(() {
      showAndHide = !showAndHide; // Toggle the visibility state
    });
  }

  var futureCall = FirebaseFirestore.instance.collection('categories').get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CategoriesPage.id);
                },
                child: Text(
                  'Categories',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              InkWell(
                onTap: () {
                  toggleShowAllCategory();
                },
                child: Text(
                  showAndHide ? 'Hide Courses' : 'See All',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: 40,
            child: FutureBuilder(
                future: futureCall,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error occurred'),
                    );
                  }

                  if (!snapshot.hasData ||
                      (snapshot.data?.docs.isEmpty ?? false)) {
                    return const Center(
                      child: Text('No categories found'),
                    );
                  }

                  var categories = List<Category>.from(snapshot.data?.docs
                          .map((e) =>
                              Category.fromJson({'id': e.id, ...e.data()}))
                          .toList() ??
                      []);
                  if (!showAndHide) {
                    categories = categories
                        .take(3)
                        .toList(); // Show only 2 courses if not "See All"
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffE0E0E0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(categories[index].name ?? 'No Name',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  );
                })),
      ],
    );
  }
}
