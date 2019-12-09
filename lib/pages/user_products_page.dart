import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../pages/edit_product_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/user_products_item.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = 'user-products-page';
  Future<void> reqProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProduts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('商品配置'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductPage.routeName);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: RefreshIndicator(
          onRefresh: () => reqProducts(context),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: products.items.length,
              itemBuilder: (ctx, index) => Column(
                    children: <Widget>[
                      UserProductsItem(
                          products.items[index].id,
                          products.items[index].imageUrl,
                          products.items[index].title),
                      Divider()
                    ],
                  ),
            ),
          ),
        ));
  }
}
