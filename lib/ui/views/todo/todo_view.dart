import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/ui/views/todo/todo_viewmodel.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

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
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(task.subtitle),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        model.updateTodoStatus(task, true);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        model.deleteTodo(task);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: model.titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a new task title',
                          ),
                        ),
                        TextField(
                          controller: model.subtitleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a new task subtitle',
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (model.isEdit ?? false) {
                              if (model.titleController.text.isNotEmpty &&
                                  model.subtitleController.text.isNotEmpty) {
                                model.editTodo(TodoModel(
                                    completed: false,
                                    uuid: model.taskValue?.uuid ?? '',
                                    title: model.titleController.text,
                                    subtitle: model.subtitleController.text));
                                model.titleController.clear();
                                model.subtitleController.clear();
                              }
                            } else {
                              if (model.titleController.text.isNotEmpty &&
                                  model.subtitleController.text.isNotEmpty) {
                                model.addTodo(model.titleController.text,
                                    model.subtitleController.text);
                                model.titleController.clear();
                                model.subtitleController.clear();
                              }
                            }
                          },
                          child: Text(
                              model.isEdit ?? false ? 'Edit Todo' : 'Add Todo'),
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
