import 'package:get/get.dart';

import '../controllers/add_doctor_detail_controller.dart';

class AddDoctorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDoctorDetailController>(
      () => AddDoctorDetailController(),
    );
  }
}
