import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = 'orders-page';

  @override
  Widget build(BuildContext context) {
    // var orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('orders page'),
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).getOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.connectionState == ConnectionState.done) {
                if (dataSnapshot.error != null) {
                  return Center(child: Text("当前暂无订单信息"));
                } else {
                  return Consumer<Orders>(builder: (ctx, orderData, child) {
                    return (orderData.orders.length == 0
                        ? Center(
                            child: Text("当前暂无订单信息"),
                          )
                        : ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (ctx, index) =>
                                OrderItem(orderData.orders[index])));
                  });
                }
              }
            }));
  }
}
