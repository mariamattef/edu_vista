import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/widgets/expansion_tile_widget.dart';
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
    return ListView(
      children: [
        ExpansionTileWidget(
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
                'Graduation : ${widget.course.instructor?.graduation_from ?? 'Not Found'}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ExpansionTileWidget(
          course: widget.course,
          titleTile: 'Course Details',
          body: [
            ListTile(
              title: Text(
                widget.course.title ?? 'No Name ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'Price Course : ${widget.course.price ?? 'NoPrice'} \$',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Course duration : ${widget.course.total_hours ?? 'No category'} Hours',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'Rating Course : ${widget.course.rating ?? 'NoRate'} Star',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    // );
  }
}
