import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final String id;
  final int todoId;
  final String title;
  final String? description;
  final String dueDate;
  final bool completed;

  TodoModel({
    required this.id,
    required this.todoId,
    required this.title,
    this.description,
    required this.dueDate,
    required this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}