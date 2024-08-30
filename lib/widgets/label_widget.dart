import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String name;
  bool showAndHide = false;
  final void Function()? onSeeAllClicked;
  LabelWidget(
      {required this.name,
      this.onSeeAllClicked,
      this.showAndHide = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          InkWell(
            onTap: onSeeAllClicked,
            child: Text(
              showAndHide ? 'Hide Courses' : 'See All',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
