import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import 'widgets/profile_button.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.blue[400]),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: GetX<ProfileController>(
                builder: (_) {
                  return Row(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: controller.photoUrl.value.isEmpty
                              ? null
                              : CachedNetworkImageProvider(
                                  controller.photoUrl.value)),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.user!.displayName!,
                            style: GoogleFonts.inter(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.user!.email!,
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          GetBuilder<ProfileController>(
            builder: (_) {
              return Visibility(
                visible: !controller.isAccountActivated,
                child: Container(
                    height: 30,
                    color: Colors.red[300],
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Your account is still not activated'.tr,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          ProfileButton(
            onTap: () {
              controller.toEditProfile();
            },
            icon: Icons.person,
            text: 'Edit Account'.tr,
          ),
          ProfileButton(
            onTap: () {
              controller.toEditDoctorDetail();
            },
            icon: Icons.edit,
            text: 'Edit Doctor Data'.tr,
          ),
          ProfileButton(
            onTap: () {
              controller.toBalance();
            },
            icon: Icons.account_balance_wallet_rounded,
            text: 'Balance'.tr,
          ),
          SizedBox(
            height: 20,
          ),
          ProfileButton(
            onTap: () {
              controller.logout();
            },
            icon: Icons.logout_outlined,
            text: 'Logout'.tr,
            hideArrowIcon: true,
          ),
          TextButton(
            onPressed: () {
              // controller.testButton();
              // LocalizationService().changeLocale('France');
              Get.toNamed(Routes.CONTACT_US);
              //controller.uploadLanguage();
            },
            child: Text('Contact Us'),
          ),
          TextButton(
            onPressed: () {
              // controller.testButton();
              // LocalizationService().changeLocale('France');
              Get.toNamed(Routes.CONTACT_US);
              //controller.uploadLanguage();
            },
            child: Text('Privacy Policy'),
          )
          //test button, you can delete it
          // ElevatedButton(
          //     onPressed: () {
          //       controller.test();
          //     },
          //     child: Text('test'))
        ],
      ),
    );
  }
}
