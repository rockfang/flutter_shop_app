import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/orders_page.dart';
import '../pages/user_products_page.dart';
import '../providers/auth.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('hello friend'),
            automaticallyImplyLeading: false,//去掉标题栏的返回箭头按钮
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop market'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('products manager'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProductsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
