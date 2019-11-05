import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final double titleHeight;
  MainDrawer(this.titleHeight);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: titleHeight,
            padding: EdgeInsets.all(8),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: Text(
              'hello friend',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop market'),
            onTap: (){
              Navigator.of(context).pushNamed('/');
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop market'),
          ),
        ],
      ),
    );
  }
}
