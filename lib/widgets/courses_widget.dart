import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/blocs/cart/cart_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/generalPage/course_details_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesWidget extends StatefulWidget {
  const CoursesWidget({
    this.rankValue,
    super.key,
    required this.futureCall,
  });
  final String? rankValue;
  final Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureCall,
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
              crossAxisCount: 2,
              childAspectRatio: .7,
              mainAxisSpacing: .9,
              crossAxisSpacing: 0,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              var rate = courses[index].rating;
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CourseDetailsPage.id,
                        arguments: courses[index],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Wrap(
                        alignment: WrapAlignment.start,
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
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  '${rate ?? 'No rank'}',
                                  style: const TextStyle(
                                    color: ColorUtility.gray,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                              ],
                            ),
                          ),
                          Text(courses[index].title ?? 'No Title',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person_2_outlined),
                              Text(
                                courses[index].instructor?.name ?? 'No name',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Text(
                                  '\$${courses[index].price ?? 'Not found'}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: ColorUtility.main,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return InkWell(
                          onTap: () {
                            context
                                .read<CartBloc>()
                                .add(AddingToCartEvent(courses[index]));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: ColorUtility.deepYellow,
                                content: Text(
                                    '${courses[index].title} added to cart'),
                              ),
                            );
                          },
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(fontSize: 14),
                          ));
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
