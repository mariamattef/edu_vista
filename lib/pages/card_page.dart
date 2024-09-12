import 'package:edu_vista/widgets/shop_item_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  static const id = 'CartPage';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Cart')),
      body: ShopItemsWidget(),
    );
  }
}
