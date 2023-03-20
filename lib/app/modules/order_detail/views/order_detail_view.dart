import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order_detail/views/widgets/video_call_button.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';
import 'package:hallo_doctor_doctor_app/app/utils/timeformat.dart';

import '../controllers/order_detail_controller.dart';
import 'widgets/user_order_tile.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Order Detail'.tr,
          style: Styles.appBarTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          //list if widget in appbar actions
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  'Cancel Appointment'.tr,
                ),
              ),
            ],
            onSelected: (int item) => {
              if (item == 0)
                {
                  //cancel appointment click
                  Get.defaultDialog(
                      title: 'Cancel Appointment'.tr,
                      content: Text(
                        'are you sure you want to cancel this appointment'.tr,
                        textAlign: TextAlign.center,
                      ),
                      onCancel: () {},
                      onConfirm: () {
                        if (controller.orderedTimeslot.status == 'booked') {
                          Get.back();
                          controller.cancelAppointment();
                        }
                        if (controller.orderedTimeslot.status == 'refund') {
                          Fluttertoast.showToast(
                              msg:
                                  'the appointment has been previously canceled'
                                      .tr);
                          Get.back();
                        }
                        if (controller.orderedTimeslot.status == 'complete') {
                          Fluttertoast.showToast(
                              msg:
                                  'The meeting has started and can\'t be canceled anymore'
                                      .tr);
                          Get.back();
                        }
                      })
                }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment with'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              UserOrderTile(
                  imgUrl: controller.orderedTimeslot.bookByWho!.photoUrl!,
                  name: controller.orderedTimeslot.bookByWho!.displayName!,
                  orderTime: controller.orderedTimeslot.purchaseTime!),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment Detail'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: controller.isReschedule ? 290 : 240,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x04000000),
                          blurRadius: 10,
                          spreadRadius: 10,
                          offset: Offset(0.0, 8.0))
                    ],
                    color: Colors.white),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          SizedBox(
                              height: 50, child: Text('Appointment Time'.tr)),
                          SizedBox(
                            height: 50,
                            child: Text(TimeFormat().formatDate(
                                controller.orderedTimeslot.timeSlot!)),
                          )
                        ]),
                        controller.isReschedule
                            ? TableRow(children: [
                                SizedBox(
                                    height: 50,
                                    child: Text('Reschedule From'.tr)),
                                SizedBox(
                                  height: 50,
                                  child: Text(TimeFormat().formatDate(controller
                                      .orderedTimeslot.pastTimeSlot!)),
                                )
                              ])
                            : TableRow(
                                children: [SizedBox(), SizedBox()],
                              ),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Duration'.tr)),
                          SizedBox(
                              height: 50,
                              child: Text(': ' +
                                  controller.orderedTimeslot.duration
                                      .toString() +
                                  ' Minute'.tr)),
                        ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Price'.tr)),
                          SizedBox(
                            height: 50,
                            child: Text(
                              currencySign +
                                  controller.orderedTimeslot.price.toString() +
                                  ' (Paid)'.tr,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Status'.tr)),
                          SizedBox(
                            height: 50,
                            child: Text(
                              controller.orderedTimeslot.status ?? "",
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Countdown'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => Visibility(
                    visible: controller.active.value,
                    child: CountDownText(
                      due: controller.orderedTimeslot.timeSlot!.toLocal(),
                      finishedText: "",
                      showLabel: true,
                      longDateName: true,
                      style: GoogleFonts.nunito(
                          color: Styles.primaryBlueColor, fontSize: 15),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Obx(() => videoCallButton(
                  active: controller.active.value,
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Start Appointment'.tr,
                        content: Text(
                            'are you sure you want to start the virtual meeting now, the user will be sent a notification that you have started the meeting'
                                .tr),
                        textCancel: 'Cancel'.tr,
                        textConfirm: 'Start Appointment'.tr,
                        onConfirm: () {
                          Get.back();
                          controller.videoCall();
                        });
                  },
                  text: 'Start Appointment'.tr)),
              SizedBox(
                height: 10,
              ),
              Text(
                'You can still start a video call appointment, even before the schedule'
                    .tr,
                style: Styles.greyTextInfoStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
