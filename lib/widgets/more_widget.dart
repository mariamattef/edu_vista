import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/widgets/widdgits/expansion_tile_widget.dart';
import 'package:flutter/material.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  bool isExpanded = false;

  ///ToDo //////////////////////////More Not Apeared
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('courses')
        .orderBy('created_date', descending: true)
        .get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.course.instructor?.name);
    return ExpansionTileWidget(
      course: widget.course,
      titleTile: 'About Instructor ',
      body: [
        ListTile(
          title: Text(
            widget.course.instructor?.name ?? 'No Name ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Years of Experience : ${widget.course.instructor?.years_of_experience ?? 'Not Found'} years',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );

    // );
  }
}
