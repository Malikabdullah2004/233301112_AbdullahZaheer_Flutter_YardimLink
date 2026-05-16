import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/login_screen.dart';
import 'create_task_screen.dart';

class OrganizationHomeScreen extends StatelessWidget {
  const OrganizationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome Organization', style: TextStyle(fontSize: 24)),
      ),
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
