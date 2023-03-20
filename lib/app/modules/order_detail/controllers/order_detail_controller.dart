import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/withdraw_settings_detail.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/notification_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/videocall_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/withdraw_service.dart';

class OrderDetailController extends GetxController {
  TimeSlot orderedTimeslot = Get.arguments;
  var database = FirebaseDatabase.instance.ref();
  NotificationService notificationService = Get.find<NotificationService>();
  var active = true.obs;
  bool isReschedule = false;
  @override
  void onInit() async {
    super.onInit();
    if (orderedTimeslot.status == 'refund') active.value = false;
    if (orderedTimeslot.pastTimeSlot != null) isReschedule = true;
  }

  @override
  void onClose() {}
  void videoCall() async {
    //
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var token =
          await VideoCallService().getAgoraToken(orderedTimeslot.timeSlotId!);
      final roomData = <String, dynamic>{
        'room': orderedTimeslot.timeSlotId,
        'token': token,
        'timestamp': Timestamp.fromDate(DateTime.now())
      };
      await VideoCallService()
          .createRoom(orderedTimeslot.timeSlotId!, roomData);
      notificationService.notificationStartAppointment(
          DoctorService.doctor!.doctorName!,
          orderedTimeslot.bookByWho!.userId!,
          orderedTimeslot.timeSlotId!,
          token,
          orderedTimeslot.timeSlotId!);
      EasyLoading.dismiss();
      Get.toNamed(
        '/video-call',
        arguments: [
          {
            'token': token,
            'room': orderedTimeslot.timeSlotId,
            'timeSlot': orderedTimeslot,
          }
        ],
      );
    } catch (e) {
      printError(info: e.toString());
      Fluttertoast.showToast(msg: e.toString());
      EasyLoading.dismiss();
    }
  }

  void cancelAppointment() async {
    try {
      EasyLoading.show();
      await TimeSlotService().cancelAppointment(orderedTimeslot);
      active.value = false;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
