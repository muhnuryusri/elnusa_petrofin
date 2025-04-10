class TodoEntity {
  TodoEntity({
    required this.id,
    required this.todoId,
    required this.title,
    required this.dueDate,
    required this.completed,
    this.description,
  });

  String id;
  int todoId;
  String title;
  String? description;
  String dueDate;
  bool completed;
}