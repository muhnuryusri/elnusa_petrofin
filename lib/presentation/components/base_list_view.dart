import 'package:elnusa_petrofin/domain/entity/todo_entity.dart';
import 'package:elnusa_petrofin/presentation/components/base_item.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<TodoEntity> items;
  final Function(TodoEntity) onItemTap;

  const CustomListView({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return BaseItem(
            title: item.title,
            dueDate: item.dueDate,
            onTap: () => onItemTap(item),
            isChecked: item.completed,
            onCheckboxChanged: (val) => item.completed = val ?? false,
          );
        },
      ),
    );
  }
}
