import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/category.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});
  static const String id = 'CategoriesPage';

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool showAndHide = false;
  bool isActive = false;
  int? activeIndex;
  var futureCall = FirebaseFirestore.instance.collection('categories').get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            ' Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: SizedBox(
                  child: FutureBuilder(
                      future: futureCall,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                .map((e) => Category.fromJson(
                                    {'id': e.id, ...e.data()}))
                                .toList() ??
                            []);

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            bool isActive = index == activeIndex;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (activeIndex == index) {
                                      activeIndex = null;
                                    } else {
                                      activeIndex = index;
                                      // Set new active index
                                    }
                                  });

                                  child:
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${categories[index].name ?? 'No Name'}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: isActive
                                                    ? ColorUtility.deepYellow
                                                    : Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              isActive
                                                  ? Icons
                                                      .keyboard_double_arrow_down
                                                  : Icons
                                                      .keyboard_double_arrow_right_rounded,
                                              color: isActive
                                                  ? ColorUtility.deepYellow
                                                  : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );

                                  // if (showAndHide) {
                                  //   fetchCourses(categories[index].name ?? '');
                                  // }
                                },
                                child: !isActive
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: ColorUtility.grayExtraLight,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${categories[index].name ?? 'No Name'}',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const Icon(Icons
                                                      .keyboard_double_arrow_right_rounded)
                                                ])),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    ColorUtility.deepYellow)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${categories[index].name ?? 'No Name'}',
                                                    style: const TextStyle(
                                                        color: ColorUtility
                                                            .deepYellow,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const Icon(
                                                  Icons
                                                      .keyboard_double_arrow_down,
                                                  color:
                                                      ColorUtility.deepYellow,
                                                )
                                              ]),
                                        ),
                                      ),
                              ),
                            );
                          },
                        );
                      })),
            ),
          ],
        ));
  }
}

























                          //  child: Padding(
                          //   padding: const EdgeInsets.all(20.0),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             '${categories[index].name ?? 'No Name'}',
                          //             style: TextStyle(
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.w500,
                          //               color: isActive
                          //                   ? ColorUtility.deepYellow
                          //                   : Colors.black,
                          //             ),
                          //           ),
                          //           Icon(
                          //             isActive
                          //                 ? Icons.keyboard_double_arrow_down
                          //                 : Icons.keyboard_double_arrow_right_rounded,
                          //             color: isActive
                          //                 ? ColorUtility.deepYellow
                          //                 : Colors.black,
                          //           ),
                          //         ],
                          //       ),
                          //       if (isActive && showAndHide)
                          //         Padding(
                          //           padding: const EdgeInsets.only(top: 10),
                          //           child: Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               const Text(
                          //                 'Courses:',
                          //                 style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold,
                          //                 ),
                          //               ),
                          //               const SizedBox(height: 5),
                          //               if (courses != null && courses!.isNotEmpty)
                          //                 ...courses!.map((course) {
                          //                   return Text(
                          //                     course['name'] ?? 'No Course Name',
                          //                     style: const TextStyle(fontSize: 14),
                          //                   );
                          //                 }).toList()
                          //               else
                          //                 const Text(
                          //                   'No courses found',
                          //                   style: TextStyle(fontSize: 14),
                          //                 ),
                          //             ],
                          //           ),
                          //         ),
                          //     ],
                          //   ),
                          // )



                        