import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/repository/todo_repository.dart';

class GetTodoListUseCase {
  final TodoRepository repository;

  GetTodoListUseCase(this.repository);

  Future<List<TodoEntity>> call() async {
    return await repository.getTodos();
  }
}