import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';

abstract class TodoRepository {
  Future<TodoEntity> addTodo(TodoModel todo);
  Future<List<TodoEntity>> getTodos();
  Future<TodoEntity> getTodoById(int id);
  Future<TodoEntity> updateTodo(int id, TodoModel todo);
  Future<void> deleteTodo(int id);
}