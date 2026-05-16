import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'log_service.dart';

class ApplicationService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<String?> applyToTask(
    String taskId, String taskTitle
  ) async {

    try {

      String userId =
          FirebaseAuth.instance.currentUser!.uid;

      // GET USER ROLE

      DocumentSnapshot userDoc =
          await _firestore
              .collection('users')
              .doc(userId)
              .get();

      String role = userDoc['role'];

      // BLOCK ORGANIZATIONS

      if (role != 'Volunteer') {
        return 'Only volunteers can apply';
      }

      // CHECK DUPLICATE

      QuerySnapshot existing =
          await _firestore
              .collection('applications')
              .where('taskId', isEqualTo: taskId)
              .where(
                'volunteerId',
                isEqualTo: userId,
              )
              .get();

      if (existing.docs.isNotEmpty) {
        return 'You already applied to this task';
      }

      await _firestore
          .collection('applications')
          .add({

        'taskId': taskId,
        'taskTitle': taskTitle,
        'volunteerId': userId,
        'status': 'pending',
        'appliedAt': Timestamp.now(),
      });

      await LogService().addLog(
        'Applied to task',
      );

      return null;

    } catch (e) {

      return e.toString();
    }
  }

    // GET APPLICATIONS FOR TASK

  Stream<QuerySnapshot> getTaskApplications(
    String taskId,
    String taskTitle
  ) {

    return _firestore
        .collection('applications')
        .where('taskId', isEqualTo: taskId)
        .snapshots();
  }

  // UPDATE STATUS

  Future<void> updateApplicationStatus({
    required String applicationId,
    required String status,
  }) async {

    await _firestore
        .collection('applications')
        .doc(applicationId)
        .update({
      'status': status,
    });

    await LogService().addLog(
      'Updated application status to $status',
    );
  }

  // GET USER APPLICATIONS

  Stream<QuerySnapshot> getUserApplications() {

    String userId =
        FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection('applications')
        .where(
          'volunteerId',
          isEqualTo: userId,
        )
        .snapshots();
  }
}