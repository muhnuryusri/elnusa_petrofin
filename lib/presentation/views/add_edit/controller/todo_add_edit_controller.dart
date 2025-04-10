import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/usecase/add_todo_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:elnusa_petrofin/data/models/todo_model.dart';

class TodoAddEditController extends GetxController {
  final AddTodoUseCase addTodo;
  final UpdateTodoUseCase updateTodo;

  TodoAddEditController({
    required this.addTodo,
    required this.updateTodo,
  });

  final titleController = TextEditingController();
  final dueDateController = TextEditingController();
  final completed = false.obs;

  final formKey = GlobalKey<FormState>();

  bool isEdit = false;
  String? id;
  int? todoId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['todo'] != null) {
      final TodoEntity todo = args['todo'];
      isEdit = true;
      id = todo.id;
      todoId = todo.todoId;
      titleController.text = todo.title;
      dueDateController.text = todo.dueDate;
      completed.value = todo.completed;
    }
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    final todo = TodoModel(
      id: id ?? "0",
      todoId: todoId ?? 0,
      title: titleController.text,
      dueDate: dueDateController.text,
      completed: completed.value,
    );

    try {
      if (isEdit && todoId != null) {
        await updateTodo(todoId!, todo);
        Get.snackbar("Success", "Todo updated successfully");
      } else {
        await addTodo(todo);
        Get.snackbar("Success", "Todo added successfully");
      }
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Failed to submit todo");
    }
  }
}
