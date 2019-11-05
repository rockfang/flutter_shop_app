import 'package:flutter/material.dart';

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
            title: Text('Shop market'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
