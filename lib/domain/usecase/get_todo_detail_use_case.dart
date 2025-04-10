import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/repository/todo_repository.dart';

class GetTodoDetailUseCase {
  final TodoRepository repository;

  GetTodoDetailUseCase(this.repository);

  Future<TodoEntity> call(int id) async {
    return await repository.getTodoById(id);
  }
}