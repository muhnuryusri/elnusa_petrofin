import 'package:elnusa_petrofin/data/repository/todo_repository_impl.dart';
import 'package:elnusa_petrofin/data/services/api_client.dart';
import 'package:elnusa_petrofin/data/services/api_service.dart';
import 'package:get/get.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut<ApiClient>(() => ApiClient());
    Get.lazyPut<ApiService>(() => ApiService(client: Get.find<ApiClient>()));
    Get.lazyPut<TodoRepositoryImpl>(
        () => TodoRepositoryImpl(apiService: Get.find<ApiService>()));
  }
}