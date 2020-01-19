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
import './pages/loading_page.dart';

import './providers/auth.dart';
import './helpers/custom_route.dart';

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
                //使用自定义路由主题
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                })),
            home: authData.isAuth()
                ? ProductsOverviewPage()
                : FutureBuilder(
                    future: authData.reloadToken(),
                    builder: (ctx, dataSnapshot) =>
                        dataSnapshot.connectionState == ConnectionState.done
                            ? AuthPage()
                            : LoadingPage()),
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
