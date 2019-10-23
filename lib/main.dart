import 'package:flutter/material.dart';
import './pages/products_overview_page.dart';
import './pages/product_detail.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '购物app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewPage(),
      routes: {
        '/product-detail': (ctx) => ProductDetail(),
      },
    );
  }
}