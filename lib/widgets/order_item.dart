import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem orditem;
  OrderItem(this.orditem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${orditem.amount}'),
            subtitle: Text(
              DateFormat('mm/dd hh:mm yyyy').format(DateTime.parse(orditem.orderTime)),
            ),
            trailing: IconButton(icon: Icon(Icons.expand_more),onPressed: (){},)
          )
        ],
      ),
    );
  }
}
