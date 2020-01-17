import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/product.dart';

class ProductDetailPage extends StatelessWidget {
  static const String routeName = "/product-detail";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<Products>(context);
    final product = products.getProductById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //动画的组件+appbar关联
          SliverAppBar(
            expandedHeight: 300,
            pinned: true, //滑动到appbar的位置，固定它，不然会滑出屏幕
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              //需要动画到appbar的原组件
              background: Hero(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
                tag: product.id,
              ),
            ), //appbar
          ),
          //正常上下滑动的部分
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${product.price}',
                style: TextStyle(color: Colors.grey, fontSize: 26),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${product.description}',
                    style: TextStyle(color: Colors.grey),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                height: 1000,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
