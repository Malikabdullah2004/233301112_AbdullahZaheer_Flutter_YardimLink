import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/task_service.dart';
import '../../widgets/task_card.dart';

class TaskListScreen extends StatelessWidget {

  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<TaskModel>>(

      stream: TaskService().getTasks(),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.isEmpty) {

          return const Center(
            child: Text(
              'No tasks available',
            ),
          );
        }

        List<TaskModel> tasks = snapshot.data!;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {

            return TaskCard(
              task: tasks[index],
            );
          },
        );
      },
    );
  }
}