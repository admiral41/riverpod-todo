class Todo {
  final String title;
  final bool completed;

  Todo({required this.title, this.completed = false});

  Todo copyWith({
    bool? completed,
  }) {
    return Todo(
      title: title,
      completed: completed ?? this.completed,
    );
  }
}
