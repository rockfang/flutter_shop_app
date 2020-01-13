import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../tools/diohttp.dart';
import '../modules/http_exception.dart';

class Auth with ChangeNotifier {
  var _token;
  DateTime _expireDat;
  String _userid;

  bool isAuth() {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expireDat != null &&
        _expireDat.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> login(email, password) async {
    try {
      final response = await DioHttp.getDio()
          .post('/user/login', data: {"email": email, "password": password});
      print(response.data);
      if (response.data['success']) {
        _token = response.data['token'];
        _userid = response.data['userid'];
        _expireDat = DateTime.now().add(Duration(seconds: response.data['expireInt']));
        DioHttp.setToken(_token);
        notifyListeners();
      } else {
        throw HttpException(response.data["message"]);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signUp(email, password) async {
    try {
      final response = await DioHttp.getDio()
          .post('/user/reg', data: {"email": email, "password": password});
      print(response.data);
      if (!response.data['success']) {
        throw HttpException(response.data["message"]);
      }
    } catch (error) {
      throw error;
    }
  }
}
