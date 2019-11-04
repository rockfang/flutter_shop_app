import 'package:flutter/foundation.dart';
import '../providers/cart.dart' show CartItem;

class OrderItem {
  final String id;
  final double amount;
  final String orderTime;
  final List<CartItem> products;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.orderTime,
      @required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  } 

  void addOrder(double amount, List<CartItem> products) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            orderTime: DateTime.now().toString(),
            amount: amount,
            products: products));
    notifyListeners();
  }
}
