import 'package:flutter/material.dart';
import 'dart:io';
import '../tools/diohttp.dart';
import './product.dart';
import '../modules/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> itemList = [];

  List<Product> get items {
    return [...itemList];
  }

  List<Product> get favoriteItems {
    return itemList.where((item) => item.isFavorite).toList();
  }

  //测试 用
  final _token;
  Products(this._token,itemList);

  Product getProductById(String id) {
    return items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchProduts() async {
    print('in products token:$_token');
    try {
      var response = await DioHttp.getDio().get('shoprepo/');
      var extractData = response.data;
      final List<Product> responseList = [];
      print("extractData:$extractData");
      if (extractData['success']) {
        List productsData = extractData['result'] as List;
        productsData.forEach((item) {
          responseList.add(Product(
            id: item['id'],
            description: item['description'],
            imageUrl: item['imageUrl'],
            price: double.parse(item['price'].toString()),
            title: item['title'],
            isFavorite: item['isFavorite'],
          ));
        });
        itemList = responseList;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      var response = await DioHttp.getDio().post('shoprepo/addProduct', data: {
        "id": DateTime.now().toString(),
        "title": product.title,
        "description": product.description,
        "imageUrl": product.imageUrl,
        "price": product.price,
        "isFavorite": product.isFavorite
      });

      var result = response.data;
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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      var response =
          await DioHttp.getDio().post('shoprepo/updateProduct', data: {
        "id": product.id,
        "title": product.title,
        "isFavorite": product.isFavorite,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
      });
      var result = response.data;
      if (result['success']) {
        int index = itemList.indexWhere((item) => item.id == product.id);
        if (index >= 0) {
          itemList[index] = product;
        }
        notifyListeners();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ///乐观删除
  Future<void> deleteProductById(String id) async {
    int index = itemList.indexWhere((item) => item.id == id);
    Product handleProduct = itemList[index];

    itemList.removeAt(index);
    notifyListeners();
    var response =
        await DioHttp.getDio().post('shoprepo/delete', data: {"id": id});
    var result = response.data;
    print("result:$result");
    if (!result['success']) {
      itemList.insert(index, handleProduct);
      notifyListeners();
      throw HttpException("刪除失败");
    }
  }

  ///乐观删除
  // void deleteProductById(String id) {
  //   const url = 'http://106.15.233.83:3010/shoprepo/delete';
  //   int index = itemList.indexWhere((item) => item.id == id);
  //   Product handleProduct = itemList[index];
  //   http
  //       .post(url,
  //           headers: {"Content-type": "application/json"},
  //           body: json.encode({"id": id}))
  //       .then((response) {
  //     var result = json.decode(response.body);
  //     if (!result['success']) {
  //       itemList.insert(index, handleProduct);
  //       notifyListeners();
  //     }
  //   }).catchError((error) {
  //     print(error);
  //     itemList.insert(index, handleProduct);
  //     notifyListeners();
  //   });
  //   itemList.removeAt(index);
  //   notifyListeners();
  // }
}
