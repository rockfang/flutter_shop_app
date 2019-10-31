import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum PopMenuOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  @override
  Widget build(BuildContext context) {
    var _showFavorite = false;
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
                    ])
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductsGrid(_showFavorite),
        ));
  }
}
