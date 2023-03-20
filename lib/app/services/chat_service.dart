import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class ChatService {
  Future getListChat() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('userIds', arrayContains: UserService().currentUser!.uid)
          .get();
      print('list chat : ' + data.docs.length.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
