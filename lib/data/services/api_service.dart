import 'package:dio/dio.dart';
import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/data/services/api_client.dart';

class ApiService {
  final ApiClient _client;

  ApiService({required ApiClient client}) : _client = client;

  Future<TodoModel> addTodo(TodoModel todo) async {
    try {
      final response = await _client.post(
        '/todos',
        todo.toJson(),
      );
      return TodoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<TodoModel>> getAllTodo() async {
    final response = await _client.get('/todos');
    return (response.data as List<dynamic>)
        .map((json) => TodoModel.fromJson(json))
        .toList();
  }

  Future<TodoModel> getTodoById(int id) async {
    try {
      final response = await _client.get('/todos/$id');
      return TodoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

    Future<TodoModel> updateTodo(int id, TodoModel todo) async {
    try {
      final response = await _client.put(
        '/todos/$id',
        todo.toJson(),
      );
      return TodoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await _client.delete('/todos/$id');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }


  dynamic _handleDioError(DioException error) {
    if (error.response != null) {
      throw HttpException(
        statusCode: error.response!.statusCode,
        message: error.response!.data['error'] ?? 'Unknown error',
      );
    }
    throw const HttpException(message: 'No internet connection');
  }
}

class HttpException implements Exception {
  final int? statusCode;
  final String message;

  const HttpException({
    this.statusCode,
    required this.message,
  });
}