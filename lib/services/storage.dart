import 'package:demofirebase/services/auth.dart';
import 'package:demofirebase/services/databse.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class StorageService {
  const StorageService();

  Future uploadFile(image) async {
    final user = await AuthService().currentUser();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/${user.uid}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    uploadTask.events.listen((event) {
      print(event.type);
    });
    storageReference
        .getDownloadURL()
        .then((url) => DBService().updateUserDoc(image: url));
  }
}
