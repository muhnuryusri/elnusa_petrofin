import 'package:elnusa_petrofin/data/repository/todo_repository_impl.dart';
import 'package:elnusa_petrofin/domain/usecase/get_todo_detail_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:elnusa_petrofin/presentation/views/detail/controller/todo_detail_controller.dart';
import 'package:get/get.dart';

class TodoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetTodoDetailUseCase(Get.find<TodoRepositoryImpl>()));

    Get.lazyPut(() => UpdateTodoUseCase(Get.find<TodoRepositoryImpl>()));

    Get.lazyPut<TodoDetailController>(
      () =>
          TodoDetailController(todoDetail: Get.find(), updateTodo: Get.find()),
    );
  }
}
