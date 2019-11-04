import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  static final routeName = 'orders-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('orders page'),
        ),
        body: Center(
          child: Text('orders'),
        ));
  }
}
