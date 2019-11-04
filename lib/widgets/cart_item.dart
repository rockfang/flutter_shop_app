import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
class CartItem extends StatelessWidget {
  final String productMapId;
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(this.productMapId,this.id,this.title, this.price, this.quantity);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(right:10),
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeOneProduct(productMapId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            )),
            title: Text(title),
            subtitle: Text('合计：\$${price * quantity}'),
            trailing: Text('x $quantity'),
          ),
        ),
      ),
    );
  }
}
