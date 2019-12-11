import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<void> getOrders() async {
    const url = 'http://106.15.233.83:3010/orders/';
    try {
      var response = await http.get(
        url,
        headers: {"Content-type": "application/json"},
      );
      var result = json.decode(response.body);
      print(result.toString());
      List<OrderItem> orders = [];
      if (result['success']) {
        var resultOrders = result['result'];
        resultOrders.forEach((item) {
          var itemProducts = item['products'];
          List<CartItem> cartItems = []; 
          itemProducts.forEach((i) {
              cartItems.add(CartItem(id: i['id'],
              price: i['price'] * 1.0,
              title: i['title'],
              quantity: i['quantity']));
          });
          orders.add(OrderItem(
              id: item['id'],
              amount: item['amount'] * 1.0,
              orderTime: item['orderTime'],
              products: cartItems));
        });
        _orders = orders;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    const url = 'http://106.15.233.83:3010/orders/addOrder';
    try {
      String id = DateTime.now().toString();
      String orderTime = DateTime.now().toString();
      var response = await http.post(url,
          headers: {"Content-type": "application/json"},
          body: json.encode({
            "id": id,
            "orderTime": orderTime,
            "amount": amount,
            "products": products,
          }));
      var result = json.decode(response.body) as Map<String, dynamic>;
      print("result:" + result.toString());
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
