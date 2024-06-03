import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'todo_viewmodel.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TodoViewModel();
}
