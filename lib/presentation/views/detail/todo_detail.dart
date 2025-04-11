import 'package:elnusa_petrofin/presentation/views/add_edit/controller/todo_add_edit_binding.dart';
import 'package:elnusa_petrofin/presentation/views/add_edit/todo_add_edit.dart';
import 'package:elnusa_petrofin/presentation/views/detail/controller/todo_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoDetailController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Detail"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  onPressed: () async {
                    final result = await Get.to(
                      () => TodoAddEdit(
                        isEdit: true,
                        todo: controller.todo.value,
                      ),
                      binding: TodoAddEditBinding(),
                    );

                    if (result == true) {
                      controller.onInit();
                    }
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Delete Todo",
                      middleText: "Are you sure you want to delete this todo?",
                      textCancel: "Cancel",
                      textConfirm: "Delete",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back();
                        controller.deleteTodoData();
                      },
                    );
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
        child: Obx(() {
          final todo = controller.todo.value;

          if (todo == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              Text(
                todo.description ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),

              Text(
                "Due Date: ${todo.dueDate}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Text("Completed", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 10),
                  Obx(
                    () => Checkbox(
                      value: controller.todo.value?.completed ?? false,
                      onChanged: (val) {
                        if (val != null) {
                          controller.updateTodoDetail(completed: val);
                        }
                      },
                    ),
                  ),
                ],
              ),

              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Back"),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
