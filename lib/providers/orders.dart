import 'package:flutter/foundation.dart';
import '../providers/cart.dart' show CartItem;
import '../tools/diohttp.dart';

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

  ///利用foreach循环嵌套处理数据
  // Future<void> getOrders() async {
  //   const url = 'http://106.15.233.83:3010/orders/';
  //   try {
  //     var response = await http.get(
  //       url,
  //       headers: {"Content-type": "application/json"},
  //     );
  //     var result = json.decode(response.body);
  //     print(result.toString());
  //     List<OrderItem> orders = [];
  //     if (result['success']) {
  //       var resultOrders = result['result'];
  //       resultOrders.forEach((item) {
  //         var itemProducts = item['products'];
  //         List<CartItem> cartItems = [];
  //         itemProducts.forEach((i) {
  //             cartItems.add(CartItem(id: i['id'],
  //             price: i['price'] * 1.0,
  //             title: i['title'],
  //             quantity: i['quantity']));
  //         });
  //         orders.add(OrderItem(
  //             id: item['id'],
  //             amount: item['amount'] * 1.0,
  //             orderTime: item['orderTime'],
  //             products: cartItems));
  //       });
  //       _orders = orders;
  //       notifyListeners();
  //     }
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  ///利用map 变换处理数据
  Future<void> getOrders() async {
    try {
      var response = await DioHttp.getDio().get(
        'orders',
      );
      var result = response.data;
      print(result.toString());
      List<OrderItem> orders = [];
      if (result['success']) {
        var resultOrders = result['result'] as List<dynamic>;
        orders = resultOrders
            .map((item) => OrderItem(
                id: item['id'],
                amount: item['amount'] * 1.0,
                orderTime: item['orderTime'],
                products: ((item['products']) as List<dynamic>)
                    .map((product) => CartItem(
                        id: product['id'],
                        price: product['price'] * 1.0,
                        title: product['title'],
                        quantity: product['quantity']))
                    .toList()))
            .toList();
        _orders = orders;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      String orderTime = DateTime.now().toString();
      var response = await DioHttp.getDio().post('orders/addOrder', data: {
        "id": id,
        "orderTime": orderTime,
        "amount": amount,
        "products": products,
      });
      var result = response.data as Map<String, dynamic>;
      print("result:" + result.toString());
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
