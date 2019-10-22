import 'package:flutter/material.dart';
import './products_overview_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '购物app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductsOverviewPage(),
    );
  }
}