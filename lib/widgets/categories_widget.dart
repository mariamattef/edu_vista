import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/category.dart';
import 'package:edu_vista/pages/generalPage/category_course_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  Axis? scrollDirection;
  double? height;
  double? heightEx;
  CategoriesWidget(
      {super.key,
      this.scrollDirection = Axis.horizontal,
      this.height = 40,
      this.heightEx = 0});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 40,
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('categories').get(),
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

          if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
            return const Center(
              child: Text('No categories found'),
            );
          }

          var categories = List<Category>.from(snapshot.data?.docs
                  .map((e) => Category.fromJson({'id': e.id, ...e.data()}))
                  .toList() ??
              []);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              // controller: ScrollController(),
              // shrinkWrap: false,
              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: widget.scrollDirection ?? Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
                height: widget.heightEx ?? 0,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CategoryCoursesPage.id,
                    arguments: categories[index].name,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorUtility.grayExtraLight,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      categories[index].name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
