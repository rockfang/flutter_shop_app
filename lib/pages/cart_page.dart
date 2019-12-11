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
                    SizedBox(width: 10,),
                    OrderButton(cart: cart),
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
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  void showSnackbar(BuildContext ctx, String message) {
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator():FlatButton(
      child: Text(
        '立即下单',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: (isLoading || widget.cart.totalAmount <= 0)
          ? null
          : () async {
              try {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.totalAmount,
                    widget.cart.getItems.values.toList());
                widget.cart.clearCart();
                // Navigator.of(context).pushNamed(OrdersPage.routeName);
                showSnackbar(context, '下单成功，可前往订单中心查看');
              } catch (_) {
                showSnackbar(context, '下单失败');
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
    );
  }
}
