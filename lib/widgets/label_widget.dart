import 'package:edu_vista/models/course.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String name;
  bool showAllCourses = false;
  final Course? courses;
  final void Function()? onSeeAllClicked;
  LabelWidget(
      {required this.name,
      this.showAllCourses = false,
      this.onSeeAllClicked,
      super.key,
      this.courses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 21, right: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          InkWell(
            onTap: onSeeAllClicked,
            child: Text(
              showAllCourses ? 'Hide Courses' : 'See All',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
