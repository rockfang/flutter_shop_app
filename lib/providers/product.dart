import 'package:flutter/foundation.dart';
import '../tools/diohttp.dart';

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
    final bool oldFavor = isFavorite;
    //先改变本地
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      var changeResult = await DioHttp.getDio().post('shoprepo/changeFavorite',
          data: {"id": id, "isFavorite": isFavorite});
      var result = changeResult.data;
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
