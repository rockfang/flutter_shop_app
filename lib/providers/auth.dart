import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../tools/diohttp.dart';
import '../modules/http_exception.dart';

class Auth with ChangeNotifier {
  var _token;
  DateTime _expireDat;
  String _userid;
  Timer autoLoginOutTimer;

  bool isAuth() {
    print("isAuth:$token");
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
    print("reloadToken:$_token");

    if (_token == null || _token.length == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        if (prefs.containsKey('tokenMsg')) {
          var tokenMsg =
              json.decode(prefs.getString('tokenMsg')) as Map<String, Object>;
          _token = tokenMsg['token'];
          _expireDat = DateTime.parse(tokenMsg['expireDat']);
          DioHttp.setToken(_token);
          notifyListeners();
        }
      } catch (error) {
        print("reloadToken error:$error");
      }
    }
    autoLoginOut();
  }

  Future<void> _saveTokenMsg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenMsg = json.encode({
      'token': _token,
      'expireDat': _expireDat.toIso8601String(),
      'userid': _userid
    });
    await prefs.setString('tokenMsg', tokenMsg);
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
        await _saveTokenMsg();
        autoLoginOut();
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

  Future<void> logout() async {
    _token = null;
    _expireDat = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("tokenMsg")) {
      await prefs.remove("tokenMsg");
      // await prefs.clear();
    }
    notifyListeners();
  }

  autoLoginOut() {
    if (autoLoginOutTimer != null) {
      autoLoginOutTimer.cancel();
      autoLoginOutTimer = null;
    }

    if (_expireDat == null || _token == null) {
      return;
    }
    print("date0:${_expireDat.toString()}");
    print("date1:${DateTime.now().toString()}");
    print(_expireDat.isBefore(DateTime.now()));

    if (_expireDat.isBefore(DateTime.now())) {
      logout();
      return;
    }
    final expireSeconds = _expireDat.difference(DateTime.now()).inSeconds;
    print('timer expireSeconds：$expireSeconds');
    autoLoginOutTimer = Timer(Duration(seconds: expireSeconds), logout);
  }
}
