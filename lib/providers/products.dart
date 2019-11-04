import 'package:flutter/material.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> itemList = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      isFavorite: false,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      isFavorite: false,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      isFavorite: false,
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572850078790&di=a4863d4021a4835751de6e5c80dbe13e&imgtype=0&src=http%3A%2F%2Fimg3.99114.com%2Fgroup1%2FM00%2F0B%2F17%2FwKgGS1jA8CuAV8CLAACUXwHCA_Q244_600_600.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      isFavorite: false,
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
      return [...itemList];
  }

   List<Product> get favoriteItems {
      return itemList.where((item) => item.isFavorite).toList();
  }

  Product getProductById(String id) {
    return items.firstWhere((item) => item.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
