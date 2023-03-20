import 'package:get/get.dart';

import '../controllers/withdraw_method_controller.dart';

class WithdrawMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawMethodController>(
      () => WithdrawMethodController(),
    );
  }
}
