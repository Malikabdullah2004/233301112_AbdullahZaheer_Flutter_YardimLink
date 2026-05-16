import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/application_service.dart';

class TaskDetailScreen extends StatelessWidget {

  final TaskModel task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  Future<bool> isVolunteer() async {

    String userId =
        FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

    return userDoc['role'] == 'Volunteer';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              task.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
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

            Text(
              task.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const Spacer(),

            FutureBuilder<bool>(
              future: isVolunteer(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                if (!snapshot.data!) {
                  return const SizedBox();
                }

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {

                      String? result =
                          await ApplicationService()
                              .applyToTask(task.id);

                      if (!context.mounted) return;

                      if (result == null) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Application submitted',
                            ),
                          ),
                        );

                      } else {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(result),
                          ),
                        );
                      }
                    },
                    child: const Text('Apply'),
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