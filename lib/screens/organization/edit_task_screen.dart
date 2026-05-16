import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;

  late TextEditingController descriptionController;

  late TextEditingController cityController;

  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task.title);

    descriptionController = TextEditingController(
      text: widget.task.description,
    );

    cityController = TextEditingController(text: widget.task.city);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    cityController.dispose();

    super.dispose();
  }

  Future<void> updateTask() async {
    String? result = await taskService.updateTask(
      taskId: widget.task.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      city: cityController.text.trim(),
    );

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task updated successfully')),
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  Future<void> deleteTask() async {
    String? result = await taskService.deleteTask(widget.task.id);

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task deleted successfully')),
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: updateTask,
                  child: const Text('Update Task'),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    bool? confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Task'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancel'),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await deleteTask();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
