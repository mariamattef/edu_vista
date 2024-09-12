// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edu_vista/models/course.dart';
// import 'package:edu_vista/pages/course_details_page.dart';
// import 'package:edu_vista/utils/color_utilis.dart';
// import 'package:flutter/material.dart';

// class CategoryCoursesTestPage extends StatefulWidget {
//   static const String id = 'category_courses_page';
//   final String categoryName;

//   const CategoryCoursesTestPage({required this.categoryName, super.key});

//   @override
//   _CategoryCoursesPageState createState() => _CategoryCoursesPageState();
// }

// class _CategoryCoursesPageState extends State<CategoryCoursesTestPage> {
//   late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

//   @override
//   void initState() {
//     super.initState();
//     futureCall = FirebaseFirestore.instance
//         .collection('courses')
//         .where('category', isEqualTo: widget.categoryName)
//         .orderBy('created_date', descending: true)
//         .get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.categoryName),
//       ),
//       body: FutureBuilder(
//         future: futureCall,
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return const Center(child: Text('Error occurred'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No courses found'));
//           }

//           var courses = snapshot.data!.docs
//               .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
//               .toList();

//           return ListView.builder(
//             itemCount: courses.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(courses[index].title ?? 'No Title'),
//                 subtitle: Text(
//                     courses[index].instructor?.name ?? 'Unknown Instructor'),
//                 trailing: Text('\$${courses[index].price.toString()}'),
//                 onTap: () {
//                   Navigator.pushNamed(context, CourseDetailsPage.id,
//                       arguments: courses[index]);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
