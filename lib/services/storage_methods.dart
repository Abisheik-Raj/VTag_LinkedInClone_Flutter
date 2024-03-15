import "dart:typed_data";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
