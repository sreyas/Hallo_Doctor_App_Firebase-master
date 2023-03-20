import 'package:flutter/animation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/balance/controllers/balance_controller.dart';

class WithrawFinishController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late AnimationController animController;
  @override
  void onInit() {
    super.onInit();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  ok() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      BalanceController balanceController = Get.find<BalanceController>();
      await Future.delayed(Duration(seconds: 3));
      await balanceController.getBalance();
      await balanceController.getTransaction();
      Get.back();
      EasyLoading.dismiss();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      EasyLoading.dismiss();
    }
  }
}
