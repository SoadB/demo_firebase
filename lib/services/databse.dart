import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demofirebase/services/auth.dart';

class DBService {
  const DBService();

  Future createUserDoc(String email, String name, String uid, {image}) async {
    final doc =
        await Firestore.instance.collection('users').document(uid).get();
    final docExist = doc.exists;
    if (!docExist)
      Firestore.instance
          .collection('users')
          .document(uid)
          .setData({'email': email, 'name': name, 'uid': uid, if(image != null) 'image': image});
  }

  Stream getUserDoc(uid) {
    return Firestore.instance.collection('users').document(uid).snapshots();
  }

  Future updateUserDoc({image}) async {
    final user = await AuthService().currentUser();
    return await Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({
      'image': image,
    });
  }
}
