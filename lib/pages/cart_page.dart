import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  static final routeName = '/cart-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart page'),
      ),
      body: Container(
        child: Text('CartPage'),
      ),
    );
  }
}
