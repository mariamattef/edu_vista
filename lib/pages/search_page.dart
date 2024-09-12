import 'package:edu_vista/pages/card_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/widdgits/categories_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const id = 'SearchPage';
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartPage.id);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          )
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Trending',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CategoriesWidget(),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Because you viewed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
