import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/course_details_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class CoursesWidget extends StatefulWidget {
  final String? categoryName; // Add this property to filter by category
  final String? rankValue;
  final String? name;
  final void Function()? onSeeAllClicked;

  const CoursesWidget({
    this.categoryName,
    this.rankValue,
    this.name,
    this.onSeeAllClicked,
    super.key,
  });

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  List<Course>? courses;
  bool showAllCourses = false;
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    super.initState();

    // Initialize futureCall with the appropriate type after applying conditions
    if (widget.rankValue != null) {
      futureCall = FirebaseFirestore.instance
          .collection('courses')
          .where('rank', isEqualTo: widget.rankValue)
          .orderBy('created_date', descending: true)
          .get();
    } else if (widget.categoryName != null) {
      futureCall = FirebaseFirestore.instance
          .collection('courses')
          .where('category', isEqualTo: widget.categoryName)
          .orderBy('created_date', descending: true)
          .get(); // Correct assignment with `.get()`
    } else {
      futureCall = FirebaseFirestore.instance
          .collection('courses')
          .orderBy('created_date', descending: true)
          .get(); // Default query if no rank or category is provided
    }
  }

  void toggleShowAllCourses() {
    setState(() {
      showAllCourses = !showAllCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.name != null) // Show title only if provided
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name!,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: toggleShowAllCourses,
                    child: Text(
                      showAllCourses ? 'Hide Courses' : 'See All',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          FutureBuilder(
              future: futureCall,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error occurred'));
                }

                if (!snapshot.hasData ||
                    (snapshot.data?.docs.isEmpty ?? false)) {
                  return const Center(child: Text('No courses found'));
                }

                var courses = snapshot.data!.docs
                    .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
                    .toList();

                if (!showAllCourses) {
                  courses = courses.take(2).toList();
                }

                return GridView.count(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(courses.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CourseDetailsPage.id,
                            arguments: courses[index]);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                            ),
                            child: Image(
                              image: NetworkImage(courses[index].image ?? ''),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (starindex) {
                                    return Icon(
                                      starindex < (courses[index].rating ?? 0)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: ColorUtility.main,
                                      size: 15,
                                    );
                                  }),
                                ),
                                Text(
                                  courses[index].title ?? 'No Name',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.person_2_outlined),
                                    const SizedBox(width: 5),
                                    Text(
                                      courses[index].instructor?.name ??
                                          'No instructor',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${courses[index].price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: ColorUtility.main,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
        ],
      ),
    );
  }
}
