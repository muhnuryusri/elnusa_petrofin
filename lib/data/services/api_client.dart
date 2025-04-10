import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = 'https://67f7ef152466325443eb4fa5.mockapi.io';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(LogInterceptor(request: true, error: true));
  }

  Future<Response> post(String path, dynamic data) async {
    return _dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return _dio.get(path);
  }

  Future<Response> put(String path, dynamic data) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }
}
