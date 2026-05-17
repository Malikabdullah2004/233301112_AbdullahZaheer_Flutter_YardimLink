import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationModel {
  final String id;
  final String taskId;
  final String volunteerId;
  final String status;
  final Timestamp appliedAt;

  ApplicationModel({
    required this.id,
    required this.taskId,
    required this.volunteerId,
    required this.status,
    required this.appliedAt,
  });

  factory ApplicationModel.fromMap(String id, Map<String, dynamic> data) {
    return ApplicationModel(
      id: id,
      taskId: data['taskId'],
      volunteerId: data['volunteerId'],
      status: data['status'],
      appliedAt: data['appliedAt'],
    );
  }
}
