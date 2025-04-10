import 'package:elnusa_petrofin/presentation/views/detail/controller/todo_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoDetailController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Todo Detail")),
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
              Text("Title:", style: Theme.of(context).textTheme.titleMedium),
              Text(todo.title, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),

              Text("Due Date:", style: Theme.of(context).textTheme.titleMedium),
              Text(todo.dueDate, style: const TextStyle(fontSize: 16)),
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
