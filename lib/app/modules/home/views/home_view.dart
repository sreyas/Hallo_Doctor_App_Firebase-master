import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/widgets/order_tile.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/widgets/profile_picture_circle.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/widgets/review_tile.dart';
import 'package:hallo_doctor_doctor_app/app/modules/widgets/empty_list_widget.dart';
import 'package:hallo_doctor_doctor_app/app/modules/widgets/section_title.dart';
import 'package:hallo_doctor_doctor_app/app/routes/app_pages.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: controller.obx(
          (dahsboardData) => Column(
            children: [
              Container(
                width: double.infinity,
                child: Obx(
                  () => Row(
                    children: [
                      profilePictureCircle(controller.profilePic.value),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Hello '.tr + controller.username.value,
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            'Welcome Back!'.tr,
                            style: GoogleFonts.nunito(
                                fontSize: 14, color: Styles.greyTextColor),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        'Doctor App'.tr,
                        style: GoogleFonts.nunito(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 10,
                        spreadRadius: 4,
                        offset: Offset(0.0, 8.0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Current Balance'.tr,
                          style: GoogleFonts.inter(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        dahsboardData!.balance == null
                            ? Text(currencySign + "0",
                                style: GoogleFonts.inter(
                                    fontSize: 40, fontWeight: FontWeight.w400))
                            : Text(
                                currencySign +
                                   controller.balvalue.toStringAsFixed(2),
                                style: GoogleFonts.inter(
                                    fontSize: 40, fontWeight: FontWeight.w400),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    VerticalDivider(),
                    // Column(
                    //   children: [
                    //     Text(
                    //       'Appointment made'.tr,
                    //       style: GoogleFonts.inter(
                    //           fontSize: 15, fontWeight: FontWeight.w400),
                    //     ),
                    //     SizedBox(
                    //       height: 5,
                    //     ),
                    //     Text(
                    //       '0',
                    //       style: GoogleFonts.inter(
                    //           fontSize: 40, fontWeight: FontWeight.w500),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Text(
                    //       'this month'.tr,
                    //       style: GoogleFonts.inter(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //           color: Styles.greyTextColor),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SectionTitle(
                title: 'Upcoming Appointment'.tr,
                subTitle: 'See More'.tr,
                onPressed: () {
                  Get.find<DashboardController>().activateTabOrder();
                },
              ),
              Container(
                  height: 200,
                  child: dahsboardData.listAppointment!.isNotEmpty
                      ? ListView.builder(
                          itemCount: dahsboardData.listAppointment!.length,
                          itemBuilder: (contex, index) => OrderTile(
                            imgUrl: dahsboardData
                                .listAppointment![index].bookByWho!.photoUrl!,
                            name: dahsboardData.listAppointment![index]
                                .bookByWho!.displayName!,
                            dateOrder: dahsboardData
                                .listAppointment![index].purchaseTime!,
                          ),
                        )
                      : EmptyList(msg: 'no order'.tr)),
              SectionTitle(
                title: 'Review'.tr,
                subTitle: 'See More'.tr,
                onPressed: () {
                  Get.toNamed(Routes.REVIEW);
                },
              ),
              Container(
                  height: 200,
                  width: Get.width,
                  child: dahsboardData.listReview!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: dahsboardData.listReview!.length,
                          itemBuilder: (contex, index) => ReviewTile(
                                name: dahsboardData.listReview![index]
                                        .userReview!.displayName ??
                                    "",
                                imgUrl: dahsboardData.listReview![index]
                                        .userReview!.photoUrl ??
                                    '',
                                rating:
                                    dahsboardData.listReview![index].rating!,
                                review:
                                    dahsboardData.listReview![index].review ??
                                        '',
                              ))
                      : EmptyList(msg: 'no review'.tr)),
            ],
          ),
        ),
      ),
    )));
  }
}
