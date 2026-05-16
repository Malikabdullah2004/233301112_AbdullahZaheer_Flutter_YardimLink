import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';
import 'log_service.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CREATE TASK

  Future<String?> createTask({
    required String title,
    required String description,
    required String city,
  }) async {
    try {
      await _firestore.collection('tasks').add({
        'title': title,
        'description': description,
        'city': city,
        'createdBy': FirebaseAuth.instance.currentUser!.uid,
        'createdAt': Timestamp.now(),
      });

      await LogService().addLog('Created task: $title');

      return null;
    } catch (e) {
      return e.toString();
    }
  }

    // UPDATE TASK

  Future<String?> updateTask({
    required String taskId,
    required String title,
    required String description,
    required String city,
  }) async {

    try {

      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update({

        'title': title,
        'description': description,
        'city': city,
      });

      await LogService().addLog(
        'Updated task: $title',
      );

      return null;

    } catch (e) {

      return e.toString();
    }
  }

  // DELETE TASK

  Future<String?> deleteTask(
    String taskId,
  ) async {

    try {

      await _firestore
          .collection('tasks')
          .doc(taskId)
          .delete();

      await LogService().addLog(
        'Deleted a task',
      );

      return null;

    } catch (e) {

      return e.toString();
    }
  }

  // GET TASKS STREAM

  Stream<List<TaskModel>> getTasks() {
    return _firestore
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }
}
