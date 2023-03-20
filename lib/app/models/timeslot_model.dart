import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class TimeSlot {
  TimeSlot(
      {this.timeSlotId,
      this.timeSlot,
      this.pastTimeSlot,
      this.duration,
      this.price,
      this.available,
      this.doctorid,
      this.bookByWho,
      this.purchaseTime,
      this.status,
      this.callstatus,
      this.parentTimeslotId});
  static const String _timeSlotId = 'timeSlotId';
  static const String _timeSlot = 'timeSlot';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _available = 'available';
  static const String _doctorId = 'doctorId';
  static const String _bookByWho = 'bookByWho';
  static const String _purchaseTime = 'purchaseTime';
  static const String _status = 'status';
  static const String _pastTimeSlot = 'pastTimeSlot';
  static const String _repeatTimeSlot = 'repeatTimeSlot';
  static const String _parentTimeslotId = 'parentTimeslotId';
  static const String _callstatus= 'callstatus';

  String? timeSlotId;
  DateTime? timeSlot;
  DateTime? pastTimeSlot;
  int? duration;
  int? price;
  bool? available;
  String? doctorid;
  UserModel? bookByWho;
  DateTime? purchaseTime;
  String? status;
  List<DateTime>? repeatTimeSlot;
  String? parentTimeslotId;
  String? callstatus;

  factory TimeSlot.fromJson(Map<String, dynamic> jsonData) {
    return TimeSlot(
        timeSlotId: jsonData[_timeSlotId],
        timeSlot: (jsonData[_timeSlot] as Timestamp).toDate().toLocal(),
        pastTimeSlot: jsonData[_pastTimeSlot] != null
            ? (jsonData[_pastTimeSlot] as Timestamp).toDate().toLocal()
            : null,
        duration: jsonData[_duration],
        price: jsonData[_price],
        available: jsonData[_available],
        doctorid: jsonData[_doctorId],
        bookByWho: jsonData[_bookByWho] != null
            ? UserModel.fromJson(jsonData[_bookByWho])
            : null,
        purchaseTime: jsonData[_purchaseTime] != null
            ? (jsonData[_purchaseTime] as Timestamp).toDate()
            : null,
        status: jsonData[_status],
        parentTimeslotId: jsonData[_parentTimeslotId],callstatus: jsonData[_callstatus]);

  }

  Map<String, dynamic> toMap(TimeSlot timeSlot) {
    if (timeSlot.timeSlot == null) {
      return {
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _available: timeSlot.available,
        _doctorId: timeSlot.doctorid,
        _parentTimeslotId: timeSlot.parentTimeslotId,
        _callstatus:timeSlot.callstatus
      };
    } else {
      return {
        _timeSlot: Timestamp.fromDate(timeSlot.timeSlot!.toUtc()),
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _available: timeSlot.available,
        _doctorId: timeSlot.doctorid,
        _parentTimeslotId: timeSlot.parentTimeslotId,
        _callstatus:timeSlot.callstatus
      };
    }
  }
}
