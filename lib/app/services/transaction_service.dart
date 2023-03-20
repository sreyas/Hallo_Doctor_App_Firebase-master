import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/transaction_model.dart' as t;
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class TransactionService {
  Future<List<t.Transaction>> getAllTransaction() async {
    try {
      var transactionSnapshot = await FirebaseFirestore.instance
          .collection('Transaction')
          .where('userId', isEqualTo: UserService.user!.uid)
          .get();
      List<t.Transaction> listTransaction = transactionSnapshot.docs.map((doc) {
        var data = doc.data();
        data['transactionId'] = doc.reference.id;
        t.Transaction transaction = t.Transaction.fromMap(data);
        return transaction;
      }).toList();
      if (listTransaction.isEmpty) return [];
      return listTransaction;
    } on FirebaseException catch (e) {
      return Future.error(e.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
