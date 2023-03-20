import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentController extends GetxController
    with StateMixin<LinkedHashMap<DateTime, List<TimeSlot>>> {
  //TODO: Implement AppointmentController

  final formKey = GlobalKey<FormBuilderState>();
  var selectedDay = DateTime.now().obs;
  var focusDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month;

  LinkedHashMap<DateTime, List<TimeSlot>> groupedEvents =
      LinkedHashMap<DateTime, List<TimeSlot>>();

  List<TimeSlot> eventSelectedDay = [];

  DashboardController dashboardController = Get.find();

  int? price;
  int? duration = 20;
  bool available = true;

  @override
  void onClose() {}

  initDoctorSchedule() {
    TimeSlotService().getDoctorTimeSlot().then(
      (value) {
        groupedEvents = groupEvent(value);
        change(groupedEvents, status: RxStatus.success());
        update();
      },
    ).catchError((err) {
      change(groupedEvents, status: RxStatus.success());
    });
  }

  List<TimeSlot> getEventsfromDay(DateTime date) {
    return groupedEvents[date] ?? [];
  }

  groupEvent(List<TimeSlot> events) {
    groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      DateTime date = DateTime(
          event.timeSlot!.year, event.timeSlot!.month, event.timeSlot!.day, 12);
      if (groupedEvents[date] == null) groupedEvents[date] = [];
      groupedEvents[date]!.add(event);
    }
    return groupedEvents;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 * key.month * 10000 * key.year;
  }

  void updateEventList(DateTime date) {
    eventSelectedDay = getEventsfromDay(date);
    update();
  }

  void updateEventsCalendar() {
    TimeSlotService().getDoctorTimeSlot().then((value) {
      groupedEvents = groupEvent(value);
      updateEventList(selectedDay.value);
      change(groupedEvents, status: RxStatus.success());
    });
  }
}
