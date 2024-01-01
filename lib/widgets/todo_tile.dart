import 'package:flutter/material.dart';

import '../model/model.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onCheckboxChanged; // Callback for checkbox change

  const TodoTile({Key? key, required this.todo, this.onCheckboxChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          // Call the callback when checkbox is changed
          if (onCheckboxChanged != null) {
            onCheckboxChanged!();
          }
        },
      ),
    );
  }
}
