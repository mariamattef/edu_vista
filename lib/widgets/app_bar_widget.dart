import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String label;
  final List<Widget>? actions;
  const AppBarWidget({required this.label, required this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        label,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.shopping_cart,
            size: 30,
          ),
        ),
      ],
    );
  }
}
