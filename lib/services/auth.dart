import 'package:demofirebase/services/databse.dart';
import 'package:firebase_auth/firebase_auth.dart';
//TODO 5: import google-sign-in

class AuthService {
  final _fb = FirebaseAuth.instance;
  final db = DBService();

  //TODO 4: Make an instance of GoogleSignIn

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

  Future loginWithGoogle() async {
    try {
      //TODO 6: Implement Google Sign In
    } catch (e) {
      //TODO 7: rethrow the exception
      //     rethrow;
    }
  }

  Future signOut() async {
    await _fb.signOut();
  }
}
