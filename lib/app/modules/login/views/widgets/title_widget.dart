import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

Widget titleApp() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/icons/ic_launcher.png',
        width: 45,
        height: 45,
      ),
      SizedBox(
        width: 10,
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Advisor'.tr,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Styles.secondaryBlueColor),
            children: [
              TextSpan(
                text: ' Biz'.tr,
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ]),
      ),
    ],
  );
}
