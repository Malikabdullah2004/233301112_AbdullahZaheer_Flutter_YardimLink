import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/application_service.dart';
import '../../widgets/empty_state.dart';

class TaskApplicationsScreen extends StatelessWidget {
  final String taskId;

  const TaskApplicationsScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applications')),

      body: StreamBuilder<QuerySnapshot>(
        stream: ApplicationService().getTaskApplications(taskId),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const EmptyState(
              icon: Icons.assignment_outlined,

              title: 'No Applications Yet',

              subtitle: 'No volunteers have applied yet.',
            );
          }

          final applications = snapshot.data!.docs;

          if (applications.isEmpty) {
            return const Center(child: Text('No applications yet'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: applications.length,

            itemBuilder: (context, index) {
              final application = applications[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        application['taskTitle'] ?? 'Volunteer Task',

                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Volunteer: '
                        '${application['volunteerName']}',
                      ),

                      Text(
                        'Email: '
                        '${application['volunteerEmail']}',
                      ),

                      const SizedBox(height: 10),

                      Text('Status: ${application['status']}'),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await ApplicationService()
                                    .updateApplicationStatus(
                                      applicationId: application.id,

                                      status: 'approved',
                                    );
                              },

                              child: const Text('Approve'),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await ApplicationService()
                                    .updateApplicationStatus(
                                      applicationId: application.id,

                                      status: 'rejected',
                                    );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),

                              child: const Text('Reject'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
