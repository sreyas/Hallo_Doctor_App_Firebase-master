import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_duration_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';
import 'package:jiffy/jiffy.dart';

class AddTimeslotController extends GetxController {
  late TimeOfDay timeSlot;
  DateTime date = Get.arguments[0]['date'];
  late DateTime newDateTime;
  late DateTime initialTime;
  TimeSlot? editedTimeSlot = Get.arguments[0]['timeSlot'];
  int? price;
  int? duration = 20;
  bool available = true;
  final formKey = GlobalKey<FormBuilderState>();
  AppointmentController appointController = Get.find();
  RepeatTimeslot repeat =
      RepeatTimeslot(repeatText: 'Not Repeat'.tr, repeat: Repeat.NOT_REPEAT);
  RepeatDuration repeatDuration =
      RepeatDuration(month: 1, monthText: '1 Month'.tr); // month
  var repeatDurationVisibility = false.obs;
  var isRepeatedTimeslot = false;
  bool isEditMode = false;
  @override
  void onInit() {
    super.onInit();
    if (editedTimeSlot != null) {
      isEditMode = true;
      newDateTime = date;
      price = editedTimeSlot!.price;
      duration = editedTimeSlot!.duration;
      timeSlot = TimeOfDay.fromDateTime(editedTimeSlot!.timeSlot!);
      isRepeatedTimeslot =
          editedTimeSlot!.parentTimeslotId != null ? true : false;
      setupInitialTime(TimeOfDay.fromDateTime(newDateTime));
      update();
    } else {
      newDateTime = date;
      print('current date time : ' + newDateTime.isUtc.toString());
      timeSlot = TimeOfDay.fromDateTime(date);
      setupInitialTime(TimeOfDay.fromDateTime(DateTime.now()));
    }
  }

  setupInitialTime(TimeOfDay time) {
    DateTime now = DateTime.now();
    initialTime =
        DateTime(date.year, date.month, date.day, now.hour, now.minute);
    newDateTime = initialTime;
    newDateTime.toLocal();
    print('initial time : ' + initialTime.toString());
    print('new date time : ' + newDateTime.toString());
  }

  @override
  void onClose() {}

  void addTimeslot() async {
    try {
      DateTime formattedDateTime =
          DateTime(newDateTime.year, newDateTime.month, newDateTime.day, 24);
      if (formattedDateTime.compareTo(DateTime.now()) < 0) {
        Fluttertoast.showToast(msg: 'Date Time is in the past'.tr);
        return;
      }
      final validationSuccess = formKey.currentState!.validate();
      if (validationSuccess) {
        formKey.currentState!.save();
        if (repeat.repeat != Repeat.NOT_REPEAT) {
          var timeslotUploadId = await addOneTimeSlot(isParent: true);
          List<DateTime> listRepeatTimeslot =
              _generateRepeatTimeslot(repeat, repeatDuration);
          await addRepeatTimeSlot(listRepeatTimeslot, timeslotUploadId);
        } else {
          await addOneTimeSlot();
        }
        Fluttertoast.showToast(msg: 'Success adding Timeslot'.tr);
        appointController.updateEventsCalendar();
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void editTimeSlot() async {
    DateTime formattedDateTime =
        DateTime(newDateTime.year, newDateTime.month, newDateTime.day, 24);
    if (formattedDateTime.compareTo(DateTime.now()) < 0) {
      Fluttertoast.showToast(msg: 'Date Time is in the past'.tr);
      return;
    }
    final validationSuccess = formKey.currentState!.validate();
    if (validationSuccess) {
      formKey.currentState!.save();
      if (isRepeatedTimeslot) {
        bool? result = await Get.defaultDialog(
            title: 'Edit Linked TimeSlot'.tr,
            middleText:
                'This timeslot is connected to several timeslots that were previously created together, do you also want to edit all timeslots that are connected to this timeslot'
                    .tr,
            radius: 15,
            textCancel: 'Edit Only this Timeslot'.tr,
            textConfirm: 'Edit All Connected Timeslot'.tr,
            onConfirm: () {
              Get.back(result: true);
            },
            onCancel: () {
              Get.back(result: false);
            });
        if (result!) {
          editedTimeSlot!.timeSlot = newDateTime;
          editedTimeSlot!.price = price;
          editedTimeSlot!.duration = duration;
          TimeSlotService()
              .updateRepeatedTimeSlot(editedTimeSlot!)
              .then((value) {
            Fluttertoast.showToast(msg: 'Success editing timeslot'.tr);
            appointController.updateEventsCalendar();
            Get.back(closeOverlays: true);
          });
        } else {
          editedTimeSlot!.timeSlot = newDateTime;
          editedTimeSlot!.price = price;
          editedTimeSlot!.duration = duration;
          TimeSlotService().updateTimeSlot(editedTimeSlot!).then((value) {
            Fluttertoast.showToast(msg: 'Success editing timeslot'.tr);
            appointController.updateEventsCalendar();
            Get.back(closeOverlays: true);
          });
        }
      } else {
        editedTimeSlot!.timeSlot = newDateTime;
        editedTimeSlot!.price = price;
        editedTimeSlot!.duration = duration;
        TimeSlotService().updateTimeSlot(editedTimeSlot!).then((value) {
          Fluttertoast.showToast(msg: 'Success editing timeslot'.tr);
          appointController.updateEventsCalendar();
          Get.back(closeOverlays: true);
        });
      }
    }
  }

  List<DateTime> _generateRepeatTimeslot(
      RepeatTimeslot repeatTimeslot, RepeatDuration repeatDuration) {
    List<DateTime> listDateTimeRepeat = [];
    switch (repeatTimeslot.repeat) {
      case Repeat.EVERY_DAY:
        int daysInMonth = Jiffy(newDateTime).daysInMonth;
        for (int i = 1; i < daysInMonth; i++) {
          DateTime dateRepeat = Jiffy(newDateTime).add(days: i).dateTime;
          listDateTimeRepeat.add(dateRepeat);
        }
        break;
      case Repeat.SAME_DAY_EVERY_WEEK:
        int week = 4 * repeatDuration.month;
        for (int i = 1; i <= week; i++) {
          DateTime dateRepeat = Jiffy(newDateTime).add(weeks: i).dateTime;
          listDateTimeRepeat.add(dateRepeat);
        }
        break;
      case Repeat.SAME_DAY_EVERY_MONTH:
        for (int i = 1; i <= repeatDuration.month; i++) {
          DateTime dateRepeat = Jiffy(newDateTime).add(months: i).dateTime;
          listDateTimeRepeat.add(dateRepeat);
        }
        break;
      default:
        return listDateTimeRepeat;
    }
    return listDateTimeRepeat;
  }

  Future deleteTimeSlot() async {
    if (isRepeatedTimeslot) {
      bool? result = await Get.defaultDialog(
          title: 'Delete Linked TimeSlot'.tr,
          middleText:
              'This timeslot is connected to several timeslots that were previously created simultaneously, do you also want to delete all timeslots that are connected to this timeslot'
                  .tr,
          radius: 15,
          textCancel: 'Cancel'.tr,
          textConfirm: 'Delete'.tr,
          onConfirm: () {
            Get.back(result: true);
          },
          onCancel: () {
            Get.back(result: false);
          });

      if (result == true) {
        await deleteRepeatedTimeslot();
      } else {
        await deleteOneTimeSlot();
      }
    } else {
      await deleteOneTimeSlot();
    }
  }

  Future deleteRepeatedTimeslot() async {
    TimeSlotService().deleteRepeatedTimeSlot(editedTimeSlot!).then((value) {
      Fluttertoast.showToast(msg: 'Successfully delete timeslot'.tr);
      appointController.updateEventsCalendar();
      Get.back(closeOverlays: true);
    });
  }

  Future deleteOneTimeSlot() async {
    TimeSlotService().deleteTimeSlot(editedTimeSlot!).then((value) {
      Fluttertoast.showToast(msg: 'Success delete timeslot'.tr);
      appointController.updateEventsCalendar();
      Get.back(closeOverlays: true);
    });
  }

  Future<String> addOneTimeSlot({bool isParent = false}) async {
    String timeSlotId = await TimeSlotService().saveDoctorTimeslot(
        dateTime: newDateTime,
        price: price!,
        duration: duration!,
        available: available,
        callstatus: "0",
        isParentTimeslot: isParent);
    if (price! < DoctorService.doctor!.doctorPrice!) {
      await DoctorService().updateDoctorBasePrice(price!);
    }
    return timeSlotId;
  }

  addRepeatTimeSlot(
      List<DateTime> listRepeatTimeslot, String parentTimeslotId) async {
    await TimeSlotService().saveMultipleTimeslot(
        dateTime: newDateTime,
        price: price!,
        duration: duration!,
        available: available,
        callstatus: "0",
        repeatTimeslot: listRepeatTimeslot,
        parentTimeslotId: parentTimeslotId);
    if (price! < DoctorService.doctor!.doctorPrice!) {
      await DoctorService().updateDoctorBasePrice(price!);
    }
  }
}
