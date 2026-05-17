import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/application_service.dart';

class MyApplicationsScreen
    extends StatelessWidget {

  const MyApplicationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(

      stream:
          ApplicationService()
              .getUserApplications(),

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
              child: ListTile(
                title: Text(
                  application['taskTitle'] ??
                      'Volunteer Task',
                ),
                subtitle: Text(
                  'Status: ${application['status']}',
                ),
              ),
            );
          },
        );
      },
    );
  }
}