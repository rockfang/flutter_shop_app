import 'package:dio/dio.dart';

// https://pub.dev/packages/dio
class DioHttp {
  static Dio dio;
  static Dio getDio() {
    if (dio == null) {
      dio = new Dio();
      dio.options.baseUrl = "http://106.15.233.83:3010/";
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.headers['content-type'] = 'application/json';
    }
    return dio;
  }

  static void setToken(token) {
    getDio().options.headers['token'] = token;
  }
}
