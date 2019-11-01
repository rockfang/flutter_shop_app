import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/products_overview_page.dart';
import './pages/product_detail_page.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './pages/cart_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: '购物app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewPage(),
        routes: {
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
        },
      ),
    );
  }
}
