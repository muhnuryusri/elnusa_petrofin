import 'package:elnusa_petrofin/core/constants/sort_type.dart';
import 'package:elnusa_petrofin/data/models/todo_model.dart';
import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/domain/usecase/get_todo_list_use_case.dart';
import 'package:elnusa_petrofin/domain/usecase/update_todo_use_case.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetTodoListUseCase getTodos;
  final UpdateTodoUseCase updateTodo;
  HomeController({required this.getTodos, required this.updateTodo});

  final todoList = <TodoEntity>[].obs;
  final sortedList = <TodoEntity>[].obs;
  final isLoading = false.obs;

  final sortType = SortType.newest.obs;

  @override
  void onInit() async {
    loadTodos();
    super.onInit();
  }

  @override
  void onReady() {
    loadTodos();
    super.onReady();
  }

  void toggleSort() {
    sortType.value =
        sortType.value == SortType.newest ? SortType.oldest : SortType.newest;
    applySort();
  }

void applySort() {
  if (sortType.value == SortType.newest) {
    sortedList.assignAll(todoList);
  } else {
    sortedList.assignAll(todoList.reversed.toList());
  }
}

  Future<void> loadTodos() async {
    try {
      isLoading.value = true;
      final todos = await getTodos();
      todoList.assignAll(todos);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleTodoCompletion(TodoEntity todo, bool value) async {
    final updatedTodo = TodoModel(
      id: todo.id,
      todoId: todo.todoId,
      title: todo.title,
      dueDate: todo.dueDate,
      completed: value,
    );

    try {
      final result = await updateTodo(int.parse(todo.id), updatedTodo);
      final index = todoList.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todoList[index] = result;
        todoList.refresh();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update todo');
    }
  }
}
