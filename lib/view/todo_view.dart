import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_class/model/model.dart';
import 'package:todo_class/provider/todo_provider.dart';
import 'package:todo_class/widgets/todo_tile.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(todoListProvider);
    final completedTasks = ref.watch(completedTodoListProvider);
    final incompleteTasks = ref.watch(incompleteTodoListProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    List<Todo> displayedTasks;
    if (selectedCategory == Category.all) {
      displayedTasks = allTasks;
    } else if (selectedCategory == Category.completed) {
      displayedTasks = completedTasks;
    } else {
      displayedTasks = incompleteTasks;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Todo App', style: TextStyle(fontSize: 34)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .setCategory(Category.all);
                    },
                    child: const Text('ALL'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .setCategory(Category.completed);
                    },
                    child: const Text('Completed'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .setCategory(Category.incomplete);
                    },
                    child: const Text('Incomplete'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: displayedTasks.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      todo: displayedTasks[index],
                      onCheckboxChanged: () {
                        ref
                            .read(todoListProvider.notifier)
                            .updateTodoStatus(displayedTasks[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController taskController = TextEditingController();

              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  controller: taskController,
                  decoration: const InputDecoration(labelText: 'Task'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final newTask = Todo(
                        title: taskController.text,
                      );
                      ref.read(todoListProvider.notifier).addTodo(newTask);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
