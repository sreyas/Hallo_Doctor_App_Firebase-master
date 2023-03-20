import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_doctor_app/app/services/firebase_service.dart';

import 'auth_service.dart';

class UserService {
  static User? user;
  set currentUser(User? user) => UserService.user = user;

  User? get currentUser {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return auth.currentUser;
    } else {
      print('User Null');
      return null;
    }
  }

  Future<String> getPhotoUrl() async {
    String? profilePic;
    try {
      profilePic = currentUser?.photoURL ?? "";
    } catch (e) {
      profilePic = '';
    }
    return profilePic;
  }

  Future<String> getDoctorId() async {
    try {
      var docRef = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: currentUser!.uid)
          .get();
      if (docRef.docs.isNotEmpty) {
        return docRef.docs.elementAt(0).get('doctorId') as String;
      } else {
        return '';
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  /// Change password
  Future changePassword(String currentPassword, String newPassword) async {
    try {
      bool validatePassword =
          await AuthService().verifyPassword(currentPassword);
      if (validatePassword) {
        currentUser!.updatePassword(newPassword);
      }
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  /// update profile pic from local storage
  Future<String> updatePhoto(File filePath) async {
    try {
      String url = await FirebaseService().uploadImage(filePath);
      currentUser!.updatePhotoURL(url);
      return url;
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  /// Update current user/local user profile url
  Future setPictureUrl(String url) async {
    try {
      currentUser!.updatePhotoURL(url);
    } catch (err) {
      Future.error(err.toString());
    }
  }

  Future updateEmail(String email) async {
    try {
      currentUser!.updateEmail(email);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future setDoctorId(String doctorId) async {
    try {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(UserService.user!.uid)
          .update({'doctorId': doctorId.toString()});
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateUserToken(String? token) async {
    try {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .update({'token': token});
    } catch (e) {
      Future.error(e.toString());
    }
  }

  Future<bool> checkIfUserExist() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();
    if (userSnapshot.exists) return true;
    return false;
  }

  Future<String> getUsername() async {
    return currentUser!.displayName!;
  }
}
