import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String description;
  final String userId;

  NoteModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.userId});

  factory NoteModel.fromDocument(Map<String, dynamic> doc, String id) {
    return NoteModel(
      id: id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      userId: doc['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
    };
  }
}
