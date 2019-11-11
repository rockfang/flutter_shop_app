import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' as ct;
import '../providers/orders.dart';
import '../pages/orders_page.dart';
import '../widgets/main_drawer.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart-page';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('cart page'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('总额:', style: TextStyle(fontSize: 24)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      '立即下单',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.totalAmount, cart.getItems.values.toList());
                      cart.clearCart();
                      Navigator.of(context).pushNamed(OrdersPage.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) {
              final item = cart.getItems.values.toList()[index];
              return ct.CartItem(cart.getItems.keys.toList()[index], item.id,
                  item.title, item.price, item.quantity);
            },
            itemCount: cart.cartProductTypes,
          ))
        ],
      ),
    );
  }
}
