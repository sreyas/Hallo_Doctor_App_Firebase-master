import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../controllers/appointment_controller.dart';

enum TimeSlotViewType { add, edit }

class AppointmentView extends GetView<AppointmentController> {
  DateTime dateTimePast = Jiffy(DateTime.now())
      .subtract(months: 1)
      .dateTime; //range calendar 1 month past from now
  DateTime dateTimeFuture = Jiffy(DateTime.now()).add(months: 6).dateTime; //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointment'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: controller.obx(
                  (data) => GetBuilder<AppointmentController>(
                    builder: (controller) => TableCalendar(
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        formatButtonTextStyle: TextStyle(color: Colors.white),
                        formatButtonShowsNext: false,
                      ),
                      focusedDay: controller.selectedDay.value,
                      firstDay: dateTimePast,
                      lastDay: dateTimeFuture,
                      eventLoader: controller.getEventsfromDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(controller.selectedDay.value, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.selectedDay.value = selectedDay;
                        controller.focusDay.value = focusedDay;
                        print('focus day :' + focusedDay.toString());
                        controller.updateEventList(selectedDay);
                      },
                      onFormatChanged: (format) {
                        controller.calendarFormat = format;
                      },
                      onPageChanged: (foucusDay) {},
                      calendarStyle: CalendarStyle(
                          canMarkersOverflow: true,
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white)),
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, date, events) => Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                        todayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GetBuilder<AppointmentController>(
                builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _.eventSelectedDay.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: _.eventSelectedDay[index].available == true
                            ? Colors.white
                            : Colors.green[300],
                        child: ListTile(
                          title: _.eventSelectedDay[index].available == true
                              ? Text(
                                  "Time Slot at ".tr +
                                      DateFormat("hh:mm a").format(
                                          _.eventSelectedDay[index].timeSlot!),
                                )
                              : Text(
                                  "Time Slot at ".tr +
                                      DateFormat("hh:mm a").format(
                                          _.eventSelectedDay[index].timeSlot!) +
                                      ' has been Ordered'.tr,
                                ),
                          subtitle: Text(
                            DateFormat("EEEE, dd MMMM, yyyy")
                                .format(_.eventSelectedDay[index].timeSlot!),
                          ),
                          trailing: _.eventSelectedDay[index].available == true
                              ? IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Get.toNamed('/add-timeslot', arguments: [
                                      {
                                        'timeSlot': _.eventSelectedDay[index],
                                        'date':
                                            _.eventSelectedDay[index].timeSlot
                                      }
                                    ]);
                                  },
                                )
                              : IconButton(
                                  icon:
                                      Icon(Icons.check_circle_outline_outlined),
                                  onPressed: () {
                                    controller
                                        .dashboardController.selectedIndex = 2;
                                  },
                                ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('/add-timeslot', arguments: [
              {'date': controller.selectedDay.value}
            ]);
          },
          label: Text('Add Timeslot'.tr),
          icon: Icon(Icons.add),
        ));
  }
}
