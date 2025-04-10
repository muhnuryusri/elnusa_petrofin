import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/usecase/get_todo_detail_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:get/get.dart';

class TodoDetailController extends GetxController {
  final GetTodoDetailUseCase todoDetail;
  final UpdateTodoUseCase updateTodo;
  TodoDetailController({required this.todoDetail, required this.updateTodo});

  final todo = Rxn<TodoEntity>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final todoId = Get.arguments['todoId'];
    if (todoId != null) {
      getFeedbackDetail(todoId);
    } else {
      errorMessage.value = 'Feedback ID is missing';
    }
  }

  Future<void> getFeedbackDetail(int id) async {
    try {
      final result = await todoDetail(id);
      todo.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }

  Future<void> updateTodoDetail({
    String? title,
    String? dueDate,
    bool? completed,
  }) async {
    if (todo.value == null) return;

    final current = todo.value!;
    final updated = TodoModel(
      id: current.id,
      todoId: current.todoId,
      title: title ?? current.title,
      dueDate: dueDate ?? current.dueDate,
      completed: completed ?? current.completed,
    );

    try {
      final result = await updateTodo(current.todoId, updated);
      todo.value = result;
      Get.snackbar('Success', 'Todo updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }
}
