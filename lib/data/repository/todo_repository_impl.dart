import 'package:dio/dio.dart';
import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/data/services/api_exception.dart';
import 'package:elnusa_petrofin/data/services/api_service.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final ApiService apiService;

  TodoRepositoryImpl({required this.apiService});

  @override
  Future<TodoEntity> addTodo(TodoModel todo) async {
    try {
      final response = await apiService.addTodo(
        TodoModel(
          id: todo.id,
          todoId: todo.todoId,
          title: todo.title,
          description: todo.description,
          dueDate: todo.dueDate,
          completed: todo.completed,
        ),
      );
      return TodoEntity(
        id: response.id,
        todoId: response.todoId,
        title: response.title,
        description: response.description ?? "",
        dueDate: response.dueDate,
        completed: response.completed,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<TodoEntity>> getTodos() async {
    try {
      final response = await apiService.getAllTodo();
      return response
          .map(
            (model) => TodoEntity(
              id: model.id,
              todoId: model.todoId,
              title: model.title,
              description: model.description ?? "",
              dueDate: model.dueDate,
              completed: model.completed,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<TodoEntity> getTodoById(int id) async {
    try {
      final response = await apiService.getTodoById(id);
      return TodoEntity(
        id: response.id,
        todoId: response.todoId,
        title: response.title,
        description: response.description ?? "",
        dueDate: response.dueDate,
        completed: response.completed,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  @override
  Future<TodoEntity> updateTodo(int id, TodoModel todo) async {
    try {
      final response = await apiService.updateTodo(
        int.parse(todo.id),
        TodoModel(
          id: todo.id,
          todoId: todo.todoId,
          title: todo.title,
          description: todo.description,
          dueDate: todo.dueDate,
          completed: todo.completed,
        ),
      );
      return TodoEntity(
        id: response.id,
        todoId: response.todoId,
        title: response.title,
        description: response.description ?? "",
        dueDate: response.dueDate,
        completed: response.completed,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await apiService.deleteTodo(id);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message = e.response!.data['error'] ?? 'Unknown error occurred';

      switch (statusCode) {
        case 400:
          return BadRequestException(message: message);
        case 404:
          return NotFoundException(message: message);
        case 500:
          return ServerException(message: message);
        default:
          return ApiException(message: message, statusCode: statusCode);
      }
    }
    return ApiException(message: 'No internet connection');
  }
}
