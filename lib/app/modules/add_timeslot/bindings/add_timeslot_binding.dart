import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/controllers/appointment_controller.dart';

import '../controllers/add_timeslot_controller.dart';

class AddTimeslotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTimeslotController>(
      () => AddTimeslotController(),
    );
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
    );
  }
}
