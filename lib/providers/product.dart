import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite});

  Future<void> toggleFavoriteStatus() async {
    const url = "http://106.15.233.83:3010/shoprepo/changeFavorite";
    final bool oldFavor = isFavorite;
    //先改变本地
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      var changeResult = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({"id": id, "isFavorite": isFavorite}));
      var result = json.decode(changeResult.body);
      //失败回退
      if (!result['success']) {
        isFavorite = oldFavor;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      isFavorite = oldFavor;
      notifyListeners();
    }
  }
}
