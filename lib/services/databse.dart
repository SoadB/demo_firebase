import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  const DBService._();

  static final DBService instance = DBService._();

  Future createUserDoc(String email, String name, String uid) async {
    final doc =
        await Firestore.instance.collection('users').document(uid).get();
    final docExist = doc.exists;

    //this is to create a new doc only if it doesn't exist before
    if (!docExist)
      Firestore.instance.collection('users').document(uid).setData({
        'email': email,
        'name': name,
        'uid': uid,
      });
  }

  Future getUserDoc(uid) {
    return Firestore.instance.collection('users').document(uid).get();
  }

}
