import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/transaction_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/balance_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/transaction_service.dart';

class BalanceController extends GetxController
    with StateMixin<List<Transaction>> {
  //TODO: Implement BalanceController

  var balance = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    initBalance();
  }

  initBalance() async {
    await getBalance();
    await getTransaction();
  }

  @override
  void onClose() {}

  Future getTransaction() async {
    change([], status: RxStatus.loading());
    try {
      var transaction = await TransactionService().getAllTransaction();
      if (transaction.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(transaction, status: RxStatus.success());
    } catch (err) {
      change([], status: RxStatus.error());
    }
  }

  getBalance() async {
    try {
      //var doctor = await DoctorService().getDoctor();
      balance.value = (await BalanceService().getBalance()) as int;
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  withdraw() {
    Get.toNamed('/withdraw-method', arguments: balance.value);
  }
}
