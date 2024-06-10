import 'package:stacked/stacked.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoService with ListenableServiceMixin {
  TodoService() {
    listenToReactiveValues([_tasks]);
  }
  final List<TodoModel> _tasks = [];
  List<TodoModel> get tasks => _tasks;

  Future<List<TodoModel>> getAllTodos() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _tasks;
  }

  void addTodo(TodoModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTodo(TodoModel task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void editTodo(TodoModel task) {
    int index = _tasks.indexWhere((t) => t.uuid == task.uuid);
    if (index != -1) {
      _tasks[index] = task;
    }
    notifyListeners();
  }
}
