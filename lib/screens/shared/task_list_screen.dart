import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/task_service.dart';
import '../../widgets/task_card.dart';
import '../../widgets/empty_state.dart';

class TaskListScreen extends StatelessWidget {
  final bool onlyMyTasks;

  TaskListScreen({super.key, this.onlyMyTasks = false});

  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TaskModel>>(
      stream: onlyMyTasks
          ? taskService.getOrganizationTasks()
          : taskService.getTasks(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyState(
            icon: Icons.assignment_outlined,

            title: 'No Tasks Found',

            subtitle: 'There are currently no available tasks.',
          );
        }

        final tasks = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),

          itemCount: tasks.length,

          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),

              child: TaskCard(task: tasks[index]),
            );
          },
        );
      },
    );
  }
}
