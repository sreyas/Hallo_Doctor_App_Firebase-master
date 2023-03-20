import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';

import '../controllers/edit_profile_controller.dart';
import 'widgets/edit_profile_tile.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Account'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Container(
          child: GetX<EditProfileController>(
            init: Get.find<EditProfileController>(),
            builder: (controller) => Column(
              children: [
                EditProfileTile(
                  title: 'Username'.tr,
                  subtitle: controller.username.value,
                ),
                Divider(
                  height: 0,
                ),
                EditProfileTile(
                  title: 'Email'.tr,
                  subtitle: controller.email.value,
                  // onTap: () {
                  //   controller.toUpdateEmail();
                  // },
                ),
                Divider(
                  height: 0,
                ),
                EditProfileTile(
                  title: 'Password'.tr,
                  subtitle: controller.password,
                  onTap: () {
                    controller.toChangePassword();
                  },
                ),
                Obx(() => EditProfileTile(
                      title: 'Base Price'.tr,
                      subtitle: currencySign +
                          ' ' +
                          controller.basePrice.value.toString(),
                      onTap: () {
                        controller.toChangeBasePrice();
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
