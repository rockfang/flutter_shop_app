class HttpException implements Exception {
  String message;
  HttpException(message);

  @override
  String toString() {
    return message;
  }
}
