import 'package:caretutors/presentation/controllers/notes_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find();
  final NotesController notesController = Get.find();

  @override
  void initState() {
    super.initState();
    notesController.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(user),
          const SizedBox(height: 16),
          _buildNotesList(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          'assets/image/icon.png',
          // width: 60,
          height: 30,
        ), // Add your logo
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Colors.indigo[900]),
          onPressed: () async => await authController.logout(),
        ),
      ],
    );
  }

  Widget _buildUserInfo(User? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Icon(Icons.email_outlined, color: Colors.indigo[300], size: 22),
          const SizedBox(width: 12),
          Text(
            user?.email ?? "Unknown User",
            style: TextStyle(
                color: Colors.indigo[700],
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    return Expanded(
      child: Obx(() {
        if (notesController.notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.note_add, size: 60, color: Colors.indigo[100]),
                const SizedBox(height: 20),
                Text(
                  "Create your first note!",
                  style: TextStyle(
                      color: Colors.indigo[300],
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }
        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemCount: notesController.notes.length,
            itemBuilder: (context, index) {
              final note = notesController.notes[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo[50]!,
                            Colors.blue[50]!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        leading: Icon(Icons.note_alt_outlined,
                            color: Colors.indigo[300]),
                        title: Text(
                          note.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.indigo[900],
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            note.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.indigo[600],
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.delete_outline,
                                color: Colors.red[300]),
                            onPressed: () =>
                                notesController.deleteNote(note.id),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.indigo[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
      onPressed: () async {
        await GoRouter.of(context).push('/add-note');
        notesController.fetchNotes();
      },
    );
  }
}
