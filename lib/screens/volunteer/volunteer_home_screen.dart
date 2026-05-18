import 'package:flutter/material.dart';
import 'package:yardimlink/screens/volunteer/my_applications_screen.dart';

import '../shared/task_list_screen.dart';
import '../shared/profile_screen.dart';

class VolunteerHomeScreen extends StatelessWidget {
  const VolunteerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyApplicationsScreen()),
              );
            },
            icon: const Icon(Icons.assignment),
          ),
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
      body:  TaskListScreen(),
    );
  }
}
