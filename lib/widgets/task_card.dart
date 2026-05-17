import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../screens/shared/task_detail_screen.dart';

class TaskCard extends StatelessWidget {

  final TaskModel task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                TaskDetailScreen(
              task: task,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // TASK TITLE

              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // TASK DESCRIPTION

              Text(
                task.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),

              const Divider(
                height: 30,
              ),

              // LOCATION

              Row(
                children: [

                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    task.city,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}