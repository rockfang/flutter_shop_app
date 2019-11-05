import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../pages/cart_page.dart';

enum PopMenuOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("购物吧"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    if (PopMenuOptions.favorite == value) {
                      _showFavorite = true;
                    } else {
                      _showFavorite = false;
                    }
                  });
                },
                icon: Icon(Icons.more_vert), //默认图标
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text("展示喜爱"), value: PopMenuOptions.favorite),
                      PopupMenuItem(
                          child: Text("展示所有"), value: PopMenuOptions.all)
                    ]),
            Consumer<Cart>(
              builder: (ctx, cart, ch) => Badge(
                child: ch,
                value: cart.cartProductTypes.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.routeName);
                },
              ),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductsGrid(_showFavorite),
        ));
  }
}
