//
// class Note {
//   final String? id;
//   final String title;
//   final String description;
//   final String userId;
//
//   Note({
//     this.id,
//     required this.title,
//     required this.description,
//     required this.userId,
//
//   });
//
//   // Convert Firestore Document to Note object
//   factory Note.fromMap(Map<String, dynamic> data, String documentId) {
//     return Note(
//       id: documentId,
//       title: data['title'] ?? '',
//       description: data['description'] ?? '',
//       userId: data['userId'] ?? '',
//     );
//   }
//
//   // Convert Note object to Firestore Document Map
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'description': description,
//       'userId': userId,
//     };
//   }
//
//   // For creating new notes (without ID)
//   Map<String, dynamic> toCreationMap() {
//     return {
//       'title': title,
//       'description': description,
//       'userId': userId,
//     };
//   }
// }