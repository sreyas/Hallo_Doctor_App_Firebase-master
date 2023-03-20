import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/review_dart.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/review_service.dart';

class ReviewController extends GetxController
    with StateMixin<List<ReviewModel>> {
  //TODO: Implement ReviewController

  final count = 0.obs;
  List<ReviewModel> listReview = [];
  @override
  void onInit() async {
    super.onInit();
    EasyLoading.show();
    try {
      Doctor? doctor = await DoctorService().getDoctor();
      if (doctor != null) {
        listReview = await ReviewService().getListReview(doctor);
        change(listReview, status: RxStatus.success());
      } else {
        change([], status: RxStatus.error());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
