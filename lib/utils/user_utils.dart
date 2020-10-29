import 'package:firebase_auth/firebase_auth.dart';

///
///
/// FIXME - Isso aqui é treta!
class UserUtils {
  static User getCurrentUser() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }
}
