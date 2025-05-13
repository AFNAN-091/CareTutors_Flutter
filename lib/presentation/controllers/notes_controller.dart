import 'package:caretutors/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _firestore
        .collection('notes')
        .where('userId', isEqualTo: user.email)
        .snapshots()
        .listen((snapshot) {
      notes.value = snapshot.docs.map((doc) {
        return NoteModel.fromDocument(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> addNote(NoteModel note) async {
    await _firestore.collection('notes').add(note.toMap());
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }
}
