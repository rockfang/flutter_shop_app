import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> reloadToken() async {
    if (_token == null || _token.length == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        _token = prefs.getString('token');
        _expireDat = DateTime.parse(prefs.getString('expireDat'));
        print('token from sp:$_token');
        print('_expireDat from sp:$_expireDat');
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> _saveTokenMsg(token, expireDat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('expireDat', expireDat);
  }

  Future<void> login(email, password) async {
    try {
      final response = await DioHttp.getDio()
          .post('/user/login', data: {"email": email, "password": password});
      print(response.data);
      if (response.data['success']) {
        _token = response.data['token'];
        _userid = response.data['userid'];
        _expireDat =
            DateTime.now().add(Duration(seconds: response.data['expireInt']));
        _saveTokenMsg(_token, _expireDat);
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
