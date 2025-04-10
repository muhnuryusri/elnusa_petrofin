// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
  id: json['id'] as String,
  todoId: (json['todoId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  dueDate: json['dueDate'] as String,
  completed: json['completed'] as bool,
);

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
  'id': instance.id,
  'todoId': instance.todoId,
  'title': instance.title,
  'description': instance.description,
  'dueDate': instance.dueDate,
  'completed': instance.completed,
};
