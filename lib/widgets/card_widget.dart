import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            'assets/images/badges.png',
            height: 200,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                ],
              ),
              Text('Your text here'),
              Row(
                children: [
                  Icon(Icons.person),
                  Text('\$ 123'),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
