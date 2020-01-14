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

      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        // Do something before request is sent
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      }, onResponse: (Response response) async {
        if(response.data['message'].contains('token校验失败')) {
          print('interceptors token校验失败');
          
        }
        return response; // continue
      }, onError: (DioError e) async {
        // Do something with response error
        return e; //continue
      }));
    }
    return dio;
  }

  static void setToken(token) {
    getDio().options.headers['token'] = token;
  }
}
