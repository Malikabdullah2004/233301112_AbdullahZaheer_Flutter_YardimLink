import 'package:flutter/material.dart';

import 'create_task_screen.dart';
import '../shared/task_list_screen.dart';
import '../shared/profile_screen.dart';

class OrganizationHomeScreen extends StatelessWidget {
  const OrganizationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: const TaskListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
