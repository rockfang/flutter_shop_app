import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = 'orders-page';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var isLoading = false;

  Future<void> reqOrders() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Orders>(context, listen: false).getOrders();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    reqOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('orders page'),
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        child: (orderData.orders.length == 0
            ? Center(
                child: Text("当前暂无订单信息"),
              )
            : ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, index) =>
                    OrderItem(orderData.orders[index]))),
        onRefresh: reqOrders,
      ),
    );
  }
}
