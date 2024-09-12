import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/card_page.dart';
import 'package:edu_vista/pages/course_details_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/widgets/courses_widget.dart';

import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  bool _showAllCourses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text(
          'Courses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartPage.id);
                },
                icon: const Icon(Icons.shopping_cart_outlined)),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    _showAllCourses = !_showAllCourses;
                    setState(() {});
                  },
                  child: const Chip(
                    label: Text('All'),
                    backgroundColor: ColorUtility.grayExtraLight,
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: !_showAllCourses
                ? Image.asset(ImageUtility.frame)
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _courseWiget(
                      futureCall: FirebaseFirestore.instance
                          .collection('courses')
                          .orderBy('created_date', descending: true)
                          .get(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _courseWiget extends StatelessWidget {
  final Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  const _courseWiget({super.key, required this.futureCall});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
          return const Center(
            child: Text('No courses found'),
          );
        }

        var courses = List<Course>.from(snapshot.data?.docs
                .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
                .toList() ??
            []);

        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              var rate = courses[index].rating;
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CourseDetailsPage.id,
                    arguments: courses[index],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Wrap(
                    // alignment: WrapAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  courses[index].image ?? 'No Image Found',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(courses[index].title ?? 'No Title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.person_2_outlined),
                                    Text(
                                      courses[index].instructor?.name ??
                                          'No name',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Start Your Course',
                                  textAlign: TextAlign.left,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                      ),
                                    ),
                                    // BlocBuilder<CartBloc, CartState>(
                                    //   builder: (context, state) {
                                    //     return TextButton(
                                    //         onPressed: () {
                                    //           context
                                    //               .read<CartBloc>()
                                    //               .add(AddToCart(courses[index]));
                                    //           ScaffoldMessenger.of(context).showSnackBar(
                                    //             SnackBar(
                                    //               content: Text(
                                    //                   '${courses[index].title} added to cart'),
                                    //             ),
                                    //           );
                                    //         },
                                    //         child: const Text(
                                    //           'Add to cart',
                                    //           style: TextStyle(fontSize: 14),
                                    //         ));
                                    //   },
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
