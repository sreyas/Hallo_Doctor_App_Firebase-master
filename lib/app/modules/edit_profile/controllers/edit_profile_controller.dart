import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/edit_profile/views/pages/change_base_price.dart';
import 'package:hallo_doctor_doctor_app/app/modules/edit_profile/views/pages/change_password_page.dart';
import 'package:hallo_doctor_doctor_app/app/modules/edit_profile/views/pages/update_email_page.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/exceptions.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final username = UserService().currentUser!.displayName.obs;
  var email = UserService().currentUser!.email.obs;
  final password = '******';
  var newPassword = ''.obs;
  var basePrice = 0.obs;
  TextEditingController textEditingBasePriceController =
      TextEditingController(text: DoctorService.doctor!.doctorPrice.toString());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    basePrice.value = DoctorService.doctor!.doctorPrice!;
  }

  @override
  void onClose() {}
  toUpdateEmail() => Get.to(() => UpdateEmailPage());
  toChangePassword() => Get.to(() => ChangePasswordPage());
  toChangeBasePrice() => Get.to(() => ChangeBasePrice());

  void updateEmail(String email) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updateEmail(email).then((value) {
      Get.back();
      this.email.value = email;
      update();
    }).catchError((err) {
      exceptionToast(err.toString());
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void changePassword(String currentPassword, String newPassword) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    try {
      await UserService().changePassword(currentPassword, newPassword);
      currentPassword = '';
      newPassword = '';
      Get.back();
      Fluttertoast.showToast(msg: 'Successfully change password'.tr);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    EasyLoading.dismiss();
  }

  Future saveBasePrice() async {
    try {
      int newBasePrice = int.parse(textEditingBasePriceController.text);
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await DoctorService().updateDoctorBasePrice(newBasePrice);
      basePrice.value = newBasePrice;
      update();
      Get.back();
    } catch (e) {
      return Future.error(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
