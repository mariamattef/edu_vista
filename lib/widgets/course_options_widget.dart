import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/app_enum.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;
  final void Function(Lecture) onLectureChosen;
  const CourseOptionsWidgets(
      {required this.courseOption,
      required this.course,
      required this.onLectureChosen,
      super.key});

  @override
  State<CourseOptionsWidgets> createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  bool showAllLectures = false;
  void toggleShowAllCourses() {
    setState(() {
      showAllLectures = !showAllLectures; // Toggle the visibility state
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.Lecture:
        return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('courses')
                .doc(widget.course.id)
                .collection('lectures')
                .get(),
            builder: (ctx, snapshot) {
              print('course Id ${widget.course.id}');
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
                  child: Text('No Lectures found'),
                );
              }

              var lectures = List<Lecture>.from(snapshot.data?.docs
                      .map((e) => Lecture.fromJson({'id': e.id, ...e.data()}))
                      .toList() ??
                  []);

              if (!showAllLectures) {
                lectures = lectures
                    .take(2)
                    .toList(); // Show only 2 courses if not "See All"
              }

              return GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(lectures.length, (index) {
                  return InkWell(
                    onTap: () => widget.onLectureChosen(lectures[index]),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorUtility.grayExtraLight,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Lecture ${index + 1}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                Icon(Icons.file_download_outlined)
                              ],
                            ),
                            Text(
                              lectures[index].title ?? 'No Name',
                            ),
                            Text(
                                lectures[index].describtion ?? 'No describtion',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300)),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Duration: ${lectures[index].duration}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300)),
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 35,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            });

      case CourseOptions.Download:
        return const SizedBox.shrink();

      case CourseOptions.Certificate:
        return const SizedBox.shrink();

      case CourseOptions.More:
        return const SizedBox.shrink();
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}
