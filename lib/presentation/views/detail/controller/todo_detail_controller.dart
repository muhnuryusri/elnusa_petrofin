import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/usecase/delete_todo_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/get_todo_detail_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:get/get.dart';

class TodoDetailController extends GetxController {
  final GetTodoDetailUseCase todoDetail;
  final UpdateTodoUseCase updateTodo;
  final DeleteTodoUseCase deleteTodo;
  TodoDetailController({
    required this.todoDetail,
    required this.updateTodo,
    required this.deleteTodo,
  });

  final todo = Rxn<TodoEntity>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final todoId = Get.arguments['todoId'];
    if (todoId != null) {
      getTodoDetail(todoId);
    } else {
      errorMessage.value = 'Todo ID is missing';
    }
  }

  Future<void> getTodoDetail(int id) async {
    try {
      final result = await todoDetail(id);
      todo.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }

  Future<void> updateTodoDetail({
    String? title,
    String? description,
    String? dueDate,
    bool? completed,
  }) async {
    if (todo.value == null) return;

    final current = todo.value!;
    final updated = TodoModel(
      id: current.id,
      todoId: current.todoId,
      title: title ?? current.title,
      description: description ?? current.description,
      dueDate: dueDate ?? current.dueDate,
      completed: completed ?? current.completed,
    );

    try {
      final result = await updateTodo(int.parse(current.id), updated);
      todo.value = result;
      Get.back(result: true);
      Get.snackbar('Success', 'Todo completed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }

  Future<void> deleteTodoData() async {
    if (todo.value == null) return;
    try {
      await deleteTodo(int.parse(todo.value!.id));
      Get.back(result: true);
      Get.snackbar('Success', 'Todo deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete todo');
    }
  }
}
