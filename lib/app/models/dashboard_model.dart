import 'dart:ffi';

import 'package:hallo_doctor_doctor_app/app/models/review_dart.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';

class DashboardModel {
  DashboardModel({this.balance, this.listReview, this.listAppointment});

  num? balance;
  List<TimeSlot>? listAppointment;
  List<ReviewModel>? listReview;
}
