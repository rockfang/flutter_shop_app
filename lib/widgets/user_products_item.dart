import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/edit_product_page.dart';
import '../providers/products.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  UserProductsItem(this.id,this.imageUrl, this.title);
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
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductPage.routeName,arguments: id);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  Provider.of<Products>(context,listen: false).deleteProductById(id);
                },
              )
            ],
          ),
        ));
  }
}
