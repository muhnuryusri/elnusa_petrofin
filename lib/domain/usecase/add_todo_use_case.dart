import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<TodoEntity> call(TodoModel feedback) async {
    return await repository.addTodo(feedback);
  }
}