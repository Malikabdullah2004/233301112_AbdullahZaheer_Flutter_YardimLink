import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String city;
  final String createdBy;
  final Timestamp createdAt;
  final String organizationName;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.createdBy,
    required this.createdAt,
    required this.organizationName,
  });

  factory TaskModel.fromMap(String id, Map<String, dynamic> data) {
    return TaskModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      city: data['city'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: data['createdAt'],
      organizationName: data['organizationName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'city': city,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}
