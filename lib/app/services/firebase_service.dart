import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

import 'package:path/path.dart';

class FirebaseService {
  Future<bool> checkUserAlreadyLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print('User Uid : ' + auth.currentUser!.uid);
      UserService.user = auth.currentUser;
      return true;
    } else {
      return false;
    }
  }

  Future userSetup(User user, String displayName) async {

    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String uid = user.uid.toString();

    users.doc(uid).set({
      'displayName': displayName,
      'email': user.email,
      'uid': uid,
      'lastLogin': user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      'createdAt': user.metadata.creationTime!.millisecondsSinceEpoch,
      'role': 'doctor'
    });
  }

  Future<String> uploadImage(File filePath) async {
    try {
      String fileName = basename(filePath.path);
      var ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      final result = await ref.putFile(File(filePath.path));
      final fileUrl = await result.ref.getDownloadURL();
      return fileUrl;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
