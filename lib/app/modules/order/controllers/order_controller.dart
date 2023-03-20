import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';

class OrderController extends GetxController with StateMixin<List<TimeSlot>> {
  final count = 0.obs;
  final isTabOpen = false;

  @override
  void onClose() {}
  void increment() => count.value++;

  void initOrderedTimeSlot() {
    change([], status: RxStatus.loading());
    TimeSlotService().getOrderedTimeSlot().then((value) {
      if (value.isEmpty) {
        change(value, status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
    }).catchError((err) {
      change([], status: RxStatus.error());
    });
  }
}
