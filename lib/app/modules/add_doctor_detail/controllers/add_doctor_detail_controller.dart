import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/pages/edit_image_page.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_category_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';
import 'package:hallo_doctor_doctor_app/app/utils/exceptions.dart';

class AddDoctorDetailController extends GetxController
    with StateMixin<List<DoctorCategory>> {
  //TODO: Implement AddDoctorDetailController

  final count = 0.obs;

  final formkey = GlobalKey<FormState>();
  var doctorName = ''.obs;
  var doctorHospital = ''.obs;
  var shortBiography = ''.obs;
  DoctorCategory? doctorCategory;
  Doctor? doctor = Get.arguments;
  var profilePicUrl = ''.obs;
  bool isEdit = false;
  String academicQualification = '';
  TextEditingController textAcademicQualificationController =
      TextEditingController();
  TextEditingController textPastExprienceInCompanyController =
      TextEditingController();
  TextEditingController textPastExprienceInConsultingController =
      TextEditingController();
  TextEditingController textConsultingFeesController = TextEditingController();
  TextEditingController textAgeController = TextEditingController();
  TextEditingController textRecognitionController = TextEditingController();
  TextEditingController textValueYouBringController = TextEditingController();
  TextEditingController textgstnoController = TextEditingController();
  TextEditingController textaddressController = TextEditingController();
  TextEditingController textpanController = TextEditingController();
  TextEditingController textmobileController = TextEditingController();

  var statecode;
  String gstno='';
  String address='';
  String gstType='Advisor';
  String pan='',mobile='';


  RxInt selectedRadio = 0.obs;

  Future<void> handleRadioValueChange(int? value) async {
    if (value != null) {
      selectedRadio.value = value;
    }
    if(value==1){
      gstType='Biz';


      var languageSettingVersionRef1 = await FirebaseFirestore.instance
          .collection('Settings')
          .doc('withdrawSetting')
          .get();

      textgstnoController.text = languageSettingVersionRef1.data()!['gstno'];
    }
  }


  @override
  void onInit() {
    super.onInit();

    if (doctor != null) {
      isEdit = true;
      profilePicUrl.value = doctor!.doctorPicture!;
      doctorName.value = doctor!.doctorName!;
      doctorHospital.value = doctor!.doctorHospital!;
      shortBiography.value = doctor!.doctorShortBiography!;
      doctorCategory = doctor!.doctorCategory!;

      update();
    }
  }


  @override
  void onClose() {}
  void increment() => count.value++;

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((imgUrl) {
      profilePicUrl.value = imgUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void toEditProfilePic() {
    Get.to(() => EditImagePage());
  }

  void initDoctorCategory() {
    DoctorCategoryService().getListDoctorCategory().then((doctorCategory) {
      change(doctorCategory, status: RxStatus.success());
    });
  }

  void saveDoctorDetail(String _selectedValue,String state,String statecode) async {


    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIGKLMNOPQRSTUVWXYZ';
    final random = Random();
    String uniquekey=String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));


    if (profilePicUrl.value.isEmpty) {
      exceptionToast('Please choose your profile photo'.tr);
      return;
    }
    if (doctorCategory == null) {
      exceptionToast('Please chose doctor Specialty or Category'.tr);
      return;
    }
    if (formkey.currentState!.validate() && doctorCategory != null) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      try {

        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final CollectionReference collection = firestore.collection('Doctors');



        while (true) {
          // Check if the number already exists in Firestore
          QuerySnapshot snapshot =
          await collection.where('uniquekey', isEqualTo: uniquekey).get();
          if (snapshot.size == 0) {

            await DoctorService().saveDoctorDetail(
              doctorName: doctorName.value,
              hospital: doctorHospital.value,
              shortBiography: shortBiography.value,
              pictureUrl: profilePicUrl.value,
              doctorCategory: doctorCategory!,
              isUpdate: isEdit,
              academicQualification: textAcademicQualificationController.text,
              basePrice: int.parse(textConsultingFeesController.text),
              age: textAgeController.text,
              pastExperienceInCompany: textPastExprienceInCompanyController.text,
              pastExperienceInConsulting:
              textPastExprienceInConsultingController.text,
              valueYouBring: textValueYouBringController.text,
              recognition: textRecognitionController.text,
              country: _selectedValue,
              state: state,
              statecode: statecode,
              gstno:textgstnoController.text,
              address:textaddressController.text,
              uniquekey:uniquekey,
              gstType:gstType,
              pan: pan,
              mobile: mobile,
            );


            break;
          } else {
            const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFG';
            final random = Random();
            uniquekey=String.fromCharCodes(Iterable.generate(
                6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));

          }
        }


        Get.offNamed('/dashboard');
        EasyLoading.dismiss();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        EasyLoading.dismiss();
      }
    }
  }

}
