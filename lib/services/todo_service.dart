import 'package:todo_app/model/todo_model.dart';

class TodoService {
  final List<TodoModel> _tasks = [];

  Future<List<TodoModel>> getAllTodos() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _tasks;
  }

  void addTodo(TodoModel task) {
    _tasks.add(task);
  }

  void removeTodo(TodoModel task) {
    _tasks.remove(task);
  }

  void editTodo(TodoModel task) {
    int index = _tasks.indexWhere((t) => t.uuid == task.uuid);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}
