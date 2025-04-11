import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/usecase/add_todo_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:elnusa_petrofin/data/models/todo_model.dart';

class TodoAddEditController extends GetxController {
  final AddTodoUseCase addTodo;
  final UpdateTodoUseCase updateTodo;

  TodoAddEditController({required this.addTodo, required this.updateTodo});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final completed = false.obs;

  final formKey = GlobalKey<FormState>();

  final isEdit = false.obs;

  void setEdit(bool value) {
    isEdit.value = value;
  }

  String? id;
  int? todoId;

  void initEditData(TodoEntity todo) {
    titleController.text = todo.title;
    descriptionController.text = todo.description ?? '';
    dueDateController.text = todo.dueDate;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['todo'] != null) {
      final TodoEntity todo = args['todo'];
      id = todo.id;
      todoId = todo.todoId;
      titleController.text = todo.title;
      descriptionController.text = todo.description ?? "";
      dueDateController.text = todo.dueDate;
      completed.value = todo.completed;
    }
  }

   void pickDueDate(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: today,
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      final formatted = DateFormat('dd-MM-yyyy').format(picked);
      dueDateController.text = formatted;
    }
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    final todo = TodoModel(
      id: id ?? "0",
      todoId: todoId ?? 0,
      title: titleController.text,
      description: descriptionController.text,
      dueDate: dueDateController.text,
      completed: false,
    );

    try {
      if (isEdit.value) {
        await updateTodo(int.parse(todo.id), todo);
        Get.back(result: true);
        Get.snackbar("Success", "Todo updated successfully");
      } else {
        await addTodo(todo);
        Get.back(result: true);
        Get.snackbar("Success", "Todo added successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to submit todo");
    }
  }
}
