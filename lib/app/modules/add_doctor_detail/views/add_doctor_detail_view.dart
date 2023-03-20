import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/pages/chose_doctor_category_page.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/widgets/display_image.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';

import '../controllers/add_doctor_detail_controller.dart';

class AddDoctorDetailView extends GetView<AddDoctorDetailController> {
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Doctor Information'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formkey,
          child: GetX<AddDoctorDetailController>(
            builder: (controller) => Column(
              children: [
                DisplayImage(
                    imagePath: controller.profilePicUrl.value,
                    onPressed: () {
                      controller.toEditProfilePic();
                    }),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  validator: ((value) {
                    if (value!.length < 3) {
                      return 'Name must be more than two characters'.tr;
                    } else {
                      return null;
                    }
                  }),
                  initialValue: controller.doctor == null
                      ? ''
                      : controller.doctorName.value,
                  onSaved: (name) {
                    controller.doctorName.value = name!;
                  },
                  decoration: InputDecoration(
                      hintText: controller.doctor == null
                          ? 'Doctor Name e.g : Dr. Maria Alexandra'.tr
                          : '',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  initialValue: controller.doctor == null
                      ? null
                      : controller.doctorHospital.value,
                  onSaved: (hospital) {
                    controller.doctorHospital.value = hospital!;
                  },
                  decoration: InputDecoration(
                      hintText: controller.doctor == null
                          ? 'the Hospital, where you work'.tr
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  onSaved: (shortBiography) {
                    controller.shortBiography.value = shortBiography!;
                  },
                  initialValue: controller.doctor == null
                      ? null
                      : controller.shortBiography.value,
                  decoration: InputDecoration(
                      hintText: controller.doctor == null
                          ? 'Short Biography'.tr
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.textAcademicQualificationController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Academic Qualification'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                      controller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.textPastExprienceInCompanyController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Past experience in Companies'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                      controller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  controller:
                      controller.textPastExprienceInConsultingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Past experience in Consulting'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                      controller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.textConsultingFeesController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Base Price',
                      helperText: 'Consulting fees for 30 minutes',
                      labelText: 'Consulting fees',
                      prefixText: 'Rs.',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.textAgeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Age',
                      helperText: 'Your Age',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.textRecognitionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Recognitions, Awards'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                      controller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.textValueYouBringController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'What value he can add to an SME client'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                      controller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    Get.to(() => ChoseDoctorCategoryPage());
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                          child: Text(controller.doctorCategory == null
                              ? 'Chose Doctor Category'.tr
                              : controller.doctorCategory!.categoryName!)),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                ),
                submitButton(
                    onTap: () {
                      controller.saveDoctorDetail();
                    },
                    text: 'Save'.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
