import 'package:firebase_auth/firebase_auth.dart';

class UserUtils {
  static User getCurrentUser() {
    final _auth = FirebaseAuth.instance;
    try {
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }

  // static Future<void> logout() async {
  //   final _auth = FirebaseAuth.instance;
  //   await _auth.signOut();
  // }
}
