class TodoModel {
  final String title;
  final String uuid;
  final String subtitle;
  final bool completed;

  const TodoModel({
    required this.uuid,
    required this.title,
    required this.subtitle,
    this.completed = false,
  });

  TodoModel copyWith({
    String? title,
    String? uuid,
    String? subtitle,
    bool? completed,
  }) {
    return TodoModel(
      title: title ?? this.title,
      uuid: uuid ?? this.uuid,
      subtitle: subtitle ?? this.subtitle,
      completed: completed ?? this.completed,
    );
  }
}
