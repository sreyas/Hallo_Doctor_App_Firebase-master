import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UserService>(
      () => UserService(),
    );
  }
}
