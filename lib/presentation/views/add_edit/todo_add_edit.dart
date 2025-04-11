import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/presentation/views/add_edit/controller/todo_add_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoAddEdit extends StatelessWidget {
  final bool? isEdit;
  final TodoEntity? todo;
  const TodoAddEdit({super.key, this.todo, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoAddEditController>();

    if (isEdit == true && todo != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.initEditData(todo!);
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ?? false ? 'Edit Todo' : 'Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator:
                    (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator:
                    (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.dueDateController,
                readOnly: true,
                onTap: () => controller.pickDueDate(context),
                decoration: const InputDecoration(labelText: 'Due Date'),
                validator:
                    (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Spacer(),
              ElevatedButton(
                onPressed: controller.onSubmit,
                child: Text(isEdit ?? false ? 'Update Todo' : 'Add Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
