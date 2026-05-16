import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/application_service.dart';

class TaskApplicationsScreen
    extends StatelessWidget {

  final String taskId;
  final String taskTitle;

  const TaskApplicationsScreen({
    super.key,
    required this.taskId,
    required this.taskTitle
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
      ),
      body: StreamBuilder<QuerySnapshot>(

        stream:
            ApplicationService()
                .getTaskApplications(taskId, taskTitle),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final applications =
              snapshot.data!.docs;

          if (applications.isEmpty) {

            return const Center(
              child: Text(
                'No applications yet',
              ),
            );
          }

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {

              final application =
                  applications[index];

              return Card(
                margin:
                    const EdgeInsets.all(12),
                child: Padding(
                  padding:
                      const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [

                      Text(
                        'Volunteer ID:',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      Text(
                        application[
                            'volunteerId'],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        'Status: ${application['status']}',
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        children: [

                          ElevatedButton(
                            onPressed:
                                () async {

                              await ApplicationService()
                                  .updateApplicationStatus(
                                applicationId:
                                    application
                                        .id,
                                status:
                                    'approved',
                              );
                            },
                            child:
                                const Text(
                              'Approve',
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          ElevatedButton(
                            onPressed:
                                () async {

                              await ApplicationService()
                                  .updateApplicationStatus(
                                applicationId:
                                    application
                                        .id,
                                status:
                                    'rejected',
                              );
                            },
                            child:
                                const Text(
                              'Reject',
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