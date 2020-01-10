import 'package:dio/dio.dart';

// https://pub.dev/packages/dio
class DioHttp {
  static Dio dio;
  static Dio getDio() {
    if (dio == null) {
      dio = new Dio(); // with default Options
      dio.options.baseUrl = "https://www.xx.com/api";
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
    }
    return dio;
  }
}
