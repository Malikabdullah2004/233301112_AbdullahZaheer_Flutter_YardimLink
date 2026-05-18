import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../screens/shared/task_detail_screen.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
          );
        },

        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.green.shade100,

                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.volunteer_activism,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        task.title,

                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Text(
                  task.description,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.green.shade50,

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: const [
                      Icon(Icons.location_on, size: 18, color: Colors.green),

                      SizedBox(width: 6),

                      Text(
                        'Volunteer Location',

                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  task.city,

                  style: TextStyle(
                    color: Colors.grey.shade700,

                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

Text(
  'Organization: ${task.organizationName}',
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
