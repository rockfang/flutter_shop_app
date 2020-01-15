import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './pages/products_overview_page.dart';
import './pages/product_detail_page.dart';
import './pages/cart_page.dart';
import './pages/orders_page.dart';
import './pages/edit_product_page.dart';
import './pages/user_products_page.dart';
import './pages/auth_page.dart';

import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', null),
            update: (ctx, auth, previousProducts) =>
                Products(auth.token, previousProducts?.itemList),
          ),
          //ChangeNotifierProvider.value(value: Products(),),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, authData, _) => MaterialApp(
            title: '购物app',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: FutureBuilder(
              future: authData.reloadToken(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.done) {
                  if (authData.isAuth()) {
                    return ProductsOverviewPage();
                  }
                  return AuthPage();
                } else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            //home: authData.isAuth() ? ProductsOverviewPage() : AuthPage(),
            routes: {
              ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
              CartPage.routeName: (ctx) => CartPage(),
              OrdersPage.routeName: (ctx) => OrdersPage(),
              UserProductsPage.routeName: (ctx) => UserProductsPage(),
              EditProductPage.routeName: (ctx) => EditProductPage(),
              AuthPage.routeName: (ctx) => AuthPage(),
              //ProductsOverviewPage.routeName: (ctx) => ProductsOverviewPage(),
            },
          ),
        ));
  }
}
