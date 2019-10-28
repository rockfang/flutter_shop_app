import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';
class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物吧"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  ProductsGrid(),
      ),
    );
  }
}


