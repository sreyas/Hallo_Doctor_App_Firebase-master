import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/services/auth_service.dart';

import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';

import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

import 'package:hallo_doctor_doctor_app/app/translation/en_US.dart';

import '../../../models/doctor_model.dart';
import '../views/pages/invoice.dart';
import '../views/pages/invoicetab.dart';


class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  var user = UserService().currentUser;
  bool tap = false;
  var photoUrl = ''.obs;
  var displayName = ''.obs;
  String? accountStatus = '';
  bool isAccountActivated = false;
  @override
  void onReady() async {
    super.onReady();
    photoUrl.value = await UserService().getPhotoUrl();
    Doctor? doc = await DoctorService().getDoctor();
    accountStatus = doc?.accountStatus!;

    if (accountStatus == 'active') {
      isAccountActivated = true;
    }
    update();
  }

  @override
  void onClose() {}

  void toEditProfile() {
    Get.toNamed('/edit-profile');
  }

  Future<void> toBalance() async {

    var doctorId = await UserService().getDoctorId();

    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(doctorId)
        .get();
    final num value = snapshot.get('balance');


    Get.toNamed('/balance', arguments: value);
    //Get.toNamed('/balance');
  }

  void toInvoice() {
    Get.to(() => InvoiceListTab());
  }
  void toEditDoctorDetail() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var doctor = DoctorService.doctor;
    EasyLoading.dismiss();
    Get.toNamed('/add-doctor-detail', arguments: doctor);
  }

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        AuthService().logout();
        Get.offAllNamed('/login');
      },
    );
  }

  void test() async {
    // //await ChatService().getListChat();
    // NotificationService().testNotification();
    await FirebaseFirestore.instance
        .collection("Settings")
        .doc('advisorLanguage')
        .set(en);
  }
}
