import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/usecase/get_todo_list_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetTodoListUseCase getTodos;
  final UpdateTodoUseCase updateTodo;
  HomeController({required this.getTodos, required this.updateTodo});

  final todoList = <TodoEntity>[].obs;

  @override
  void onInit() async {
    loadTodos();
    super.onInit();
  }

  @override
  void onReady() {
    loadTodos();
    super.onReady();
  }

  Future<void> loadTodos() async {
    try {
      final todos = await getTodos();
      todoList.assignAll(todos);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }

  Future<void> toggleTodoCompletion(TodoEntity todo, bool value) async {
    final updatedTodo = TodoModel(
      id: todo.id,
      todoId: todo.todoId,
      title: todo.title,
      dueDate: todo.dueDate,
      completed: value,
    );

    try {
      final result = await updateTodo(int.parse(todo.id), updatedTodo);
      final index = todoList.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todoList[index] = result;
        todoList.refresh();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }
}
