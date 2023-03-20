import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/user_model.dart';

class Order {
  TimeSlot timeSlot;
  UserModel orderByWho;
  Order({required this.timeSlot, required this.orderByWho});
}
