import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_class/model/model.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>(
  (ref) => TodoList(),
);

// Modify the updateTodoStatus method in todo_provider.dart
class TodoList extends StateNotifier<List<Todo>> {
  TodoList() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodoStatus(Todo todo) {
    state = state.map((t) {
      return t == todo
          ? t.copyWith(completed: !t.completed)
          : t.copyWith(
              completed:
                  t.completed); // Copy existing task to maintain immutability
    }).toList(growable: false); // Explicitly cast to List<Todo>
  }

  @override
  List<Todo> build() {
    throw UnimplementedError();
  }
}

enum Category {
  all,
  completed,
  incomplete,
}

final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategory, Category>((ref) {
  return SelectedCategory();
});

class SelectedCategory extends StateNotifier<Category> {
  SelectedCategory() : super(Category.all);

  void setCategory(Category category) {
    state = category;
  }

  @override
  Category build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final completedTodoListProvider = Provider<List<Todo>>((ref) {
  final allTasks = ref.watch(todoListProvider);
  return allTasks.where((task) => task.completed).toList();
});

final incompleteTodoListProvider = Provider<List<Todo>>((ref) {
  final allTasks = ref.watch(todoListProvider);
  return allTasks.where((task) => !task.completed).toList();
});
