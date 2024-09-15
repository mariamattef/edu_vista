import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/blocs/cart/cart_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/cart_page/card_page.dart';
import 'package:edu_vista/pages/generalPage/course_details_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/widgets/Custom_text_button.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopItemsPage extends StatefulWidget {
  static const id = 'ShopItemsWidget';
  const ShopItemsPage({super.key});

  @override
  State<ShopItemsPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<ShopItemsPage> {
  bool _showAllCourses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text(
          'Add To Cart',
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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
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
class _courseWiget extends StatefulWidget {
  final Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  bool isSelected;
  String courseSelected;
  _courseWiget(
      {required this.futureCall,
      this.isSelected = false,
      this.courseSelected = '0'});

  @override
  State<_courseWiget> createState() => _courseWigetState();
}

class _courseWigetState extends State<_courseWiget> {
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
            // shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3.4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              // var rate = courses[index].rating;
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CourseDetailsPage.id,
                    arguments: courses[index],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 130,
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
                            padding: const EdgeInsets.only(right: 20, top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(courses[index].title ?? 'No Title',
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
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
                                          overflow: TextOverflow.ellipsis),
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
                                // ignore: avoid_unnecessary_containers
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 0,
                                ),
                              ),
                              BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                return IconButton(
                                    isSelected: !widget.isSelected,
                                    onPressed: () {
                                      widget.isSelected != widget.isSelected;
                                      context.read<CartBloc>().add(
                                          AddingToCartEvent(courses[index]));
                                      // BlocProvider.of<CartBloc>(context).add(
                                      //     RemovingFromCartEvent(
                                      //         courses[index]));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              ColorUtility.deepYellow,
                                          content: Text(
                                              '${courses[index].title} added to cart'),
                                        ),
                                      );
                                    },
                                    icon: widget.isSelected
                                        ? const Text('AddToCart')
                                        : const Icon(
                                            Icons.shopping_cart_checkout,
                                            color: ColorUtility.deepYellow,
                                            size: 30,
                                          ));
                              })
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
