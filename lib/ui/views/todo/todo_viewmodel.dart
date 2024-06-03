import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';

class TodoViewModel extends BaseViewModel {
  final TodoService _taskService = GetIt.instance<TodoService>();

  List<TodoModel> _tasks = [];
  List<TodoModel> get tasks => _tasks;

  Future<void> fetchTodos() async {
    setBusy(true);
    _tasks = await _taskService.getAllTodos();
    setBusy(false);
    notifyListeners();
  }

  void addTodo(String title, String subtitle) {
    _taskService.addTodo(TodoModel(title: title, subtitle: subtitle));
    fetchTodos();
  }

  void updateTodoStatus(TodoModel task, bool completed) {
    _taskService.editTodo(task.copyWith(completed: completed));
    fetchTodos();
  }

  void deleteTodo(TodoModel task) {
    _taskService.removeTodo(task);
    fetchTodos();
  }

  void editTodo(TodoModel updatedTask) {
    _taskService.editTodo(updatedTask);
    fetchTodos();
  }
}
