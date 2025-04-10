import 'package:elnusa_petrofin/presentation/components/base_item.dart';
import 'package:elnusa_petrofin/presentation/views/add_edit/controller/todo_add_edit_binding.dart';
import 'package:elnusa_petrofin/presentation/views/add_edit/todo_add_edit.dart';
import 'package:elnusa_petrofin/presentation/views/detail/controller/todo_detail_binding.dart';
import 'package:elnusa_petrofin/presentation/views/detail/todo_detail.dart';
import 'package:elnusa_petrofin/presentation/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Todo List", style: TextStyle(fontSize: 25)),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: controller.todoList.length,
                        itemBuilder: (context, index) {
                          final todo = controller.todoList[index];
                          print(
                            "Todo => ID: ${todo.todoId}, Title: ${todo.title}, Completed: ${todo.completed}",
                          );
                          return BaseItem(
                            title: todo.title,
                            dueDate: todo.dueDate,
                            onTap: () {
                              Get.to(
                                () => TodoDetail(),
                                arguments: {'todoId': int.parse(todo.id)},
                                binding: TodoDetailBinding(),
                              );
                            },
                            isChecked: todo.completed,
                            onCheckboxChanged: (val) {
                              controller.toggleTodoCompletion(todo, val ?? false);
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 26, right: 26, bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => TodoAddEdit(), binding: TodoAddEditBinding());
                },
                child: Text("Add New Todo"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
