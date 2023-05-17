import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';

class BalanceService {
  Future<num> getBalance() async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(DoctorService.doctor!.doctorId)
          .get();
      Doctor doctor =
          Doctor.fromJson(userSnapshot.data() as Map<String, dynamic>);
      return doctor.doctorBalance!;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future createBalance(User user, Doctor doctor) async {
    try {
      CollectionReference balances =
          FirebaseFirestore.instance.collection('Balance');

      Map<String, dynamic> balance = {
        'user': user.uid,
        'doctorId': doctor.doctorId
      };
      balances.add(balance);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
