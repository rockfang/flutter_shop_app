import 'package:flutter/material.dart';

class UserProductsItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  UserProductsItem(this.imageUrl, this.title);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
          width: 110,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Theme.of(context).errorColor,
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
