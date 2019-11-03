import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final _showFav;
  ProductsGrid(this._showFav);
  @override
  Widget build(BuildContext context) {
    ///拿到数据源对象
    final productsData = Provider.of<Products>(context);
    ///通过数据源对象获取数据
    final products = _showFav ? productsData.favoriteItems : productsData.items;
    print(products.length);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(),
          ),
      itemCount: products.length,
    );
  }
}
