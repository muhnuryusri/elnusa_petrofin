import 'package:elnusa_petrofin/data/repository/todo_repository_impl.dart';
import 'package:elnusa_petrofin/domain/usecase/get_todo_list_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:elnusa_petrofin/presentation/views/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetTodoListUseCase(Get.find<TodoRepositoryImpl>()));

    Get.lazyPut(() => UpdateTodoUseCase(Get.find<TodoRepositoryImpl>()));

    Get.lazyPut<HomeController>(
      () => HomeController(getTodos: Get.find(), updateTodo: Get.find()),
    );
  }
}
