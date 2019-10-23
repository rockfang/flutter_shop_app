import 'package:flutter/material.dart';

import '../yummy_products.dart';
import '../widgets/product_item.dart';

class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物吧"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10),
          itemBuilder: (ctx, i) => ProductItem(YUMMY_PRODUCTS[i].id,
              YUMMY_PRODUCTS[i].title, YUMMY_PRODUCTS[i].imageUrl),
          itemCount: YUMMY_PRODUCTS.length,
        ),
      ),
    );
  }
}
