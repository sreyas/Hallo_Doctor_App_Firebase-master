import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/auth_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  var loginFormKey = GlobalKey<FormState>();
  var username = '';
  var password = '';
  bool passwordVisible = true;

  @override
  void onClose() {}
  void increment() => count.value++;

  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      AuthService().login(username, password).then((value) {
        //Check whether, user is already set his detail doctor in server
        AuthService().checkDoctorDetail().then((doctorDetail) {
          if (doctorDetail) GetStorage().write(checkDoctorDetail, true);
          Get.offNamed('/dashboard');
        });
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }
}
