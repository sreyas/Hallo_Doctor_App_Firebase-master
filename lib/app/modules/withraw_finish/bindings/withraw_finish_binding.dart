import 'package:get/get.dart';

import '../controllers/withraw_finish_controller.dart';

class WithrawFinishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithrawFinishController>(
      () => WithrawFinishController(),
    );
  }
}
