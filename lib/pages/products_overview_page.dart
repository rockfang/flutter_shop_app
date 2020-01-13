import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../pages/cart_page.dart';
import '../providers/products.dart';

enum PopMenuOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
static const routeName = "products-overview-page";

  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _showFavorite = false;
  var _isInitiated = false;
  var _showLoading = false;

  Future<void> reqProducts() async{
    await Provider.of<Products>(context, listen: false).fetchProduts();
  }
  @override
  void initState() {
    // Provider.of<Products>(context).fetchProduts(); //won't work
    //Provider.of<Products>(context,listen: false).fetchProduts();// will work
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<Products>(context).fetchProduts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInitiated) {
      setState(() {
        _showLoading = true;
      });

      reqProducts().then((_) {
        setState(() {
          _showLoading = false;
        });
      });
    }
    _isInitiated = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物吧"),
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
      body: _showLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: reqProducts,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsGrid(_showFavorite),
              )),
    );
  }
}
