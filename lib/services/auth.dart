import 'package:demofirebase/services/databse.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _fb = FirebaseAuth.instance;
  final db = DBService();

  Future currentUser() async {
    return await _fb.currentUser();
  }

  Future registerWithEmail(String email, String password, String name) async {
    try {
      await _fb.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = await currentUser();
      await db.createUserDoc(email, name, user.uid);
    } catch (e) {
      rethrow;
    }
  }

  Future loginWithEmail(String email, String password) async {
    try {
      await _fb.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future signOut() async {
    await _fb.signOut();
  }
}
