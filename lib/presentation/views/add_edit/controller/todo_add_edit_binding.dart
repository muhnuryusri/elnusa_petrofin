import 'package:elnusa_petrofin/data/repository/todo_repository_impl.dart';
import 'package:elnusa_petrofin/domain/usecase/add_todo_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:elnusa_petrofin/presentation/views/add_edit/controller/todo_add_edit_controller.dart';
import 'package:get/get.dart';

class TodoAddEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTodoUseCase(Get.find<TodoRepositoryImpl>()));

    Get.lazyPut(() => UpdateTodoUseCase(Get.find<TodoRepositoryImpl>()));

    Get.lazyPut<TodoAddEditController>(
      () =>
          TodoAddEditController(addTodo: Get.find(), updateTodo: Get.find()),
    );
  }
}
