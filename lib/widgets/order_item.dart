import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orditem;
  OrderItem(this.orditem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expandedOrder = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text('\$${widget.orditem.amount}'),
              subtitle: Text(
                DateFormat('MM/dd hh:mm yyyy')
                    .format(DateTime.parse(widget.orditem.orderTime)),
              ),
              trailing: IconButton(
                icon:
                    Icon(expandedOrder ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    expandedOrder = !expandedOrder;
                  });
                },
              )),
          if (expandedOrder)
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                height: min(180, widget.orditem.products.length * 22.0 + 30),
                child: ListView.builder(
                    itemCount: widget.orditem.products.length,
                    itemBuilder: (ctx, index) {
                      var product = widget.orditem.products[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '${product.quantity} x \$${product.price}',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      );
                    }))
        ],
      ),
    );
  }
}
