import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/ui/views/todo/todo_viewmodel.dart';

class TodoView extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      onModelReady: (model) => model.fetchTodos(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('To-Do App'),
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.tasks.length,
                      itemBuilder: (context, index) {
                        final TodoModel task = model.tasks[index];
                        return ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(task.subtitle),
                          trailing: Checkbox(
                            value: task.completed,
                            onChanged: (value) {
                              model.updateTodoStatus(task, value!);
                            },
                          ),
                          onLongPress: () => model.deleteTodo(task),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a new task title',
                          ),
                        ),
                        TextField(
                          controller: _subtitleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a new task subtitle',
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (_titleController.text.isNotEmpty &&
                                _subtitleController.text.isNotEmpty) {
                              model.addTodo(_titleController.text,
                                  _subtitleController.text);
                              _titleController.clear();
                              _subtitleController.clear();
                            }
                          },
                          child: const Text('Add Todo'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
