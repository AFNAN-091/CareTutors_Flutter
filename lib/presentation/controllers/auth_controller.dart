import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Get.rawSnackbar(message: 'Login successful');
      redirectAfterLogin();
    } on FirebaseAuthException catch (e) {
      // Get.rawSnackbar(title: 'Error', message: e.message ?? 'Login failed');
    }
  }

//   return Scaffold(
//   backgroundColor: Colors.white,
//   appBar: AppBar(
//   backgroundColor: Colors.white,
//   elevation: 0,
//   title: Padding(
//   padding: const EdgeInsets.all(12.0),
//   child: Image.asset(
//   'assets/image/icon.png',
//   // width: 60,
//   height: 30,
//   ), // Add your logo
//   ),
//   centerTitle: true,
//   // leading: Text('My Notes',
//   //     style: theme.textTheme.titleLarge?.copyWith(
//   //       fontWeight: FontWeight.w700,
//   //       color: Colors.blueGrey[800],
//   //     )),
//   actions: [
//   IconButton(
//   icon: Icon(Icons.logout, color: Colors.blueGrey[800]),
//   onPressed: () async => await authController.logout(),
//   ),
//   ],
//   ),
//   body: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//   _buildUserInfoSection(user),
//   const SizedBox(height: 16),
//   _buildNotesList(),
//   ],
//   ),
//   floatingActionButton: _buildAddButton(context),
//   );
// }
  Future<void> register(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        await user!.updateDisplayName(name);
        // Get.rawSnackbar(message: 'Registration successful');
        _redirectToLogin();
      } else {
        // Get.rawSnackbar(title: 'Error', message: 'User not created properly');
      }
    } on FirebaseAuthException catch (e) {
      // Get.rawSnackbar(
      //     title: 'Error', message: e.message ?? 'Registration failed');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      // Get.rawSnackbar(message: 'Logged out successfully');
      GoRouter.of(Get.context!).go('/login');
    } catch (e) {
      // Get.rawSnackbar(title: 'Logout Error', message: e.toString());
    }
  }

  // Helper methods for navigation with null safety
  void redirectAfterLogin() {
    final context = Get.context;
    if (context != null && context.mounted) {
      GoRouter.of(context).go('/home');
    }
  }

  void _redirectToLogin() {
    final context = Get.context;
    if (context != null && context.mounted) {
      GoRouter.of(context).go('/login');
    }
  }
}
