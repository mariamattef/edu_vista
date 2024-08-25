import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseSrorageReference {
  static FirebaseStorage? storage;
  static void init() async {
    try {
      storage = FirebaseStorage.instance;

      print('storage is setup Successfully');
    } catch (e) {
      print('Failed to initialize storage: $e');
    }
  }

  // final mountainsRef = storageRef.child("mountains.jpg");
  Future<String> uploadFile({required String uid, required File file}) async {
    final fileName = file.uri.pathSegments.last;

    final filePath = "$uid/$fileName";

    final uploadTask =
        FirebaseStorage.instance.ref().child(filePath).putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }
}
