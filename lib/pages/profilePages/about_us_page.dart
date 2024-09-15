import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/widdgits/categories_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  static const String id = 'AboutUsPage';

  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.gbScaffold,
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to EduVista',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'EduVista is an innovative educational platform offering a variety of courses across multiple categories. Our mission is to make quality education accessible to everyone.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Image.asset('assets/images/banner.png'),
            const SizedBox(height: 16),
            const Text(
              'Explore Our Courses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our courses are organized by categories, making it easy to find content that suits your interests. Each course is further divided into a series of lectures to help you learn step by step.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CategoriesWidget(
              scrollDirection: Axis.vertical,
              height: 500,
              heightEx: 10,
            ),
          ],
        ),
      ),
    );
  }
}
