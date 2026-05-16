import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/application_service.dart';
import '../organization/task_applications_screen.dart';

import '../organization/edit_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  Future<bool> isVolunteer() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    return userDoc['role'] == 'Volunteer';
  }

  bool isOwner() {
    return FirebaseAuth.instance.currentUser!.uid == task.createdBy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          if (isOwner())
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
                );
              },
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.location_on),

                const SizedBox(width: 8),

                Text(task.city),
              ],
            ),

            const SizedBox(height: 20),

            Text(task.description, style: const TextStyle(fontSize: 16)),

            const Spacer(),

            FutureBuilder<bool>(
              future: isVolunteer(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                bool volunteer = snapshot.data!;

                if (volunteer) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? result = await ApplicationService().applyToTask(
                          task.id,
                          task.title,
                        );

                        if (!context.mounted) return;

                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Application submitted'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(result)));
                        }
                      },
                      child: const Text('Apply'),
                    ),
                  );
                }

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskApplicationsScreen(
                            taskId: task.id,
                            taskTitle: task.title,
                          ),
                        ),
                      );
                    },
                    child: const Text('View Applications'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
