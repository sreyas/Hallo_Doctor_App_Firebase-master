import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';

class VideoCallService {
  var database = FirebaseDatabase.instance.ref();

  Future<String> getAgoraToken(String roomName) async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('generateToken');
      final results =
          await callable({'channelName': roomName, 'role': 'publisher'});
      var clientSecret = results.data;
      print('token : ' + clientSecret);
      return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future removeRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .delete();
      //await database.child('room/' + roomName).remove();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future createRoom(String roomId, Map<String, dynamic> roomData) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .set(roomData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
