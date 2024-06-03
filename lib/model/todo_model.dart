class TodoModel {
  final String title;
  final String subtitle;
  final bool completed;

  const TodoModel({
    required this.title,
    required this.subtitle,
    this.completed = false,
  });

  TodoModel copyWith({
    String? title,
    String? subtitle,
    bool? completed,
  }) {
    return TodoModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      completed: completed ?? this.completed,
    );
  }
}
