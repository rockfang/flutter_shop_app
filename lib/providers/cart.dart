import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;
  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get getItems {
    return {..._items};
  }

  int get cartProductTypes {
    return _items.length;
  }

  double get totalAmount {
    var amount =0.0;
    _items.forEach((key,item) {
      amount += item.price * item.quantity;
    });
    return amount;
  }

  void addOneItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (item) => CartItem(
              id: id, title: title, price: price, quantity: item.quantity + 1));
    } else {
      _items.putIfAbsent(
          id, () => CartItem(id: id, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeOneProduct(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
