import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../tools/diohttp.dart';
import '../modules/http_exception.dart';

class Auth with ChangeNotifier {
  var _token;
  DateTime _expireDat;
  String _userid;

  String get token {
    return _token;
  }

  Future<void> login(email, password) async {
    try {
      final response = await DioHttp.getDio()
          .post('/user/login', data: {"email": email, "password": password});
      print(response.data);
      if (response.data['success']) {
        _token = response.data['token'];
        DioHttp.setToken(_token);
      } else {
        throw HttpException(response.data["msg"]);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(email, password) async {
    try {
      final response = await DioHttp.getDio()
          .post('/user/reg', data: {"email": email, "password": password});
      print(response.data);
      if (!response.data['success']) {
        throw HttpException(response.data["msg"]);
      }
    } catch (error) {
      throw error;
    }
  }
}
