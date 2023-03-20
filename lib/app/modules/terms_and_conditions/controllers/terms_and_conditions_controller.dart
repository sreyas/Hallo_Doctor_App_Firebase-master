import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../services/settings_service.dart';

class TermsAndConditionsController extends GetxController {
  //TODO: Implement TermsAndConditionsController

  final count = 0.obs;
  var termsAndConditions = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadTermsAndConditions();
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
  Future loadTermsAndConditions() async {
    try {
      EasyLoading.show();
      termsAndConditions.value =
          await SettingsService().getTermsAndConditions();
    } catch (e) {
      return Future.error(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
