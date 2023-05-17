import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/models/dashboard_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/review_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';
import 'package:synchronized/synchronized.dart';

class HomeController extends GetxController with StateMixin<DashboardModel> {
  //TODO: Implement HomeController

  final count = 0.obs;
  final username = ''.obs;
  final profilePic = ''.obs;
  DashboardModel dashboardModel = DashboardModel();
  var lock = Lock();
  late  num balvalue=0;
  @override
  void onReady() async {
    super.onReady();
    var doctor = await DoctorService().getDoctor();

    if (doctor == null) {
      if (await UserService().checkIfUserExist() == false) {
        return Get.offNamed('/login');
      } else {
        return Get.offNamed('/add-doctor-detail');
      }
    }
    username.value = UserService().currentUser!.displayName!;
    UserService()
        .getPhotoUrl()
        .then((urlPicture) => profilePic.value = urlPicture);

    await getListAppointment();
    await getListReview(doctor);
    getBalance();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  //Check whether, user is already set his detail doctor
  bool checkDetailDoctor() {
    bool? check = GetStorage().read(checkDoctorDetail);
    if (check == null || !check) return false;
    return true;
  }

  getListAppointment() async {
    try {
      dashboardModel.listAppointment =
          await TimeSlotService().getOrderedTimeSlot(limit: 5);
    } catch (err) {
      printError(info: err.toString());
    }
  }

  getListReview(Doctor doctor) async {
    try {
      dashboardModel.listReview = await ReviewService().getListReview(
        doctor,
      );
    } catch (err) {
      printError(info: err.toString());
    }
  }

  getBalance() async {
    var doctorId = await UserService().getDoctorId();

    num balance = 0.0;

    // final DocumentSnapshot snapshot = await FirebaseFirestore.instance
    //     .collection('Doctors')
    //     .doc(doctorId)
    //     .get();
    //
    // if (snapshot.exists) {
    //   final num value = snapshot.get('balance');
    //   balvalue=value;
    //   // Use the fieldValue or perform further operations
    // } else {
    //   balvalue=0;
    // }


    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctorId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        balance = (data['balance'] ?? 0.0);
        balvalue=balance;

      }
    } catch (e) {
      print('Error retrieving doctor balance: $e');
    }


    print("aaaaaaaaa");
    print(doctorId);




    dashboardModel.balance = DoctorService.doctor!.doctorBalance;
    change(dashboardModel, status: RxStatus.success());
  }
}
