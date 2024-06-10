import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:uuid/uuid.dart';

class TodoViewModel extends ReactiveViewModel {
  final TodoService _taskService = locator<TodoService>();

  List<TodoModel> _tasks = [];
  List<TodoModel> get tasks => _tasks;
  TodoModel? taskValue;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  bool? isEdit;
  Future<void> fetchTodos() async {
    setBusy(true);
    _tasks = await _taskService.getAllTodos();
    setBusy(false);
    notifyListeners();
  }

  void addTodo(String title, String subtitle) {
    _taskService.addTodo(
        TodoModel(title: title, subtitle: subtitle, uuid: const Uuid().v4()));
    fetchTodos();
  }

  void updateTodoStatus(TodoModel task, bool completed) {
    titleController.text = task.title;
    subtitleController.text = task.subtitle;
    isEdit = completed;
    taskValue = task;
  }

  void deleteTodo(TodoModel task) {
    _taskService.removeTodo(task);
    fetchTodos();
  }

  void editTodo(TodoModel updatedTask) {
    _taskService.editTodo(updatedTask);
    isEdit = false;
    fetchTodos();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskService];
}
