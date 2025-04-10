import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<TodoEntity> call(int id, TodoModel todo) async {
    return await repository.updateTodo(id, todo);
  }
}
