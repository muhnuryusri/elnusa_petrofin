import 'package:flutter/material.dart';

class BaseItem extends StatelessWidget {
  final String title;
  final String? description;
  final String dueDate;
  final VoidCallback onTap;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;

  const BaseItem({
    super.key,
    required this.title,
    this.description,
    required this.dueDate,
    required this.onTap,
    required this.isChecked,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 8),
            InkWell(onTap: onTap, child: Column(
              children: [
                Text(title),
                Text(dueDate),
              ],
            )),

            const SizedBox(height: 4),
            Checkbox(value: isChecked, onChanged: onCheckboxChanged),
          ],
        ),
      ),
    );
  }
}
