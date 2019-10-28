import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  static final String routeName = "/product-detail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(ModalRoute.of(context).settings.arguments),
    ));
  }
}
