import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/product.dart';
class ProductDetailPage extends StatelessWidget {
  static final String routeName = "/product-detail";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<Products>(context);
    final product = products.getProductById(productId);
    return Scaffold(
        appBar: AppBar(
      title: Text(product.title),
    ));
  }
}
