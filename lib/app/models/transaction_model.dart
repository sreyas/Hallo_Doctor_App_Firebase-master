import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/withdraw_method_model.dart';

class Transaction {
  Transaction(
      {this.transactionId,
      this.withdrawMethod,
      this.userId,
      this.amount,
      this.status,
      this.type,
      this.timeSlot,
      this.createdAt});
  String? transactionId;
  WithdrawMethod? withdrawMethod;
  String? userId;
  int? amount;
  String? status;
  String? type;
  TimeSlot? timeSlot;
  DateTime? createdAt;
  static const String _transactionId = 'transactionId';
  static const String _withdrawMethod = 'withdrawMethod';
  static const String _userId = 'userId';
  static const String _amount = 'amount';
  static const String _status = 'status';
  static const String _type = 'type';
  static const String _timeslot = 'timeslot';
  static const String _createdAt = 'createdAt';

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        transactionId: map[_transactionId],
        withdrawMethod: map[_withdrawMethod] != null
            ? WithdrawMethod.fromJson(map[_withdrawMethod])
            : null,
        userId: map[_userId],
        amount: map[_amount],
        status: map[_status],
        type: map[_type],
        timeSlot: map[_timeslot],
        createdAt: (map[_createdAt] as Timestamp).toDate());
  }
}
