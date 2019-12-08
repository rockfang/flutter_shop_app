import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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

  void addProduct(Product product) {
    const url = 'http://106.15.233.83:3010/shoprepo/addProduct';
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "id": DateTime.now().toString(),
              "title": product.title,
              "description": product.description,
              "imageUrl": product.imageUrl,
              "price": product.price,
              "isFavorite": product.isFavorite
            }))
        .then((response) {
      var result = json.decode(response.body);
      print('Response body: $result');
      if (result['success']) {
        itemList.add(Product(
            id: DateTime.now().toString(),
            title: product.title,
            description: product.description,
            imageUrl: product.imageUrl,
            price: product.price,
            isFavorite: product.isFavorite));
        notifyListeners();
      }
    });
  }

  Future<void> updateProduct(Product product) async {
    //hacker 把数据存入服务端，插入方式，delete later
    const url = 'http://106.15.233.83:3010/shoprepo/addProduct';
    var response = await http.post(url,
        headers: {"Content-type": "application/json"},
        body: json.encode({
          "id": product.id,
          "title": product.title,
          "isFavorite": product.isFavorite,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var result = json.decode(response.body);
    if (result['success']) {
      int index = itemList.indexWhere((item) => item.id == product.id);
      if (index >= 0) {
        itemList[index] = product;
      }
      notifyListeners();
    }
  }

  void deleteProductById(String id) {
    itemList.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
