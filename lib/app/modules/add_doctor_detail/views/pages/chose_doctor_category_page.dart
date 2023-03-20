import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/controllers/add_doctor_detail_controller.dart';
import 'package:hallo_doctor_doctor_app/app/utils/search/search_doctor_category.dart';

class ChoseDoctorCategoryPage extends GetView<AddDoctorDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.initDoctorCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Category'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          controller.obx(
            (doctorCategory) => IconButton(
              onPressed: () async {
                controller.doctorCategory = await showSearch(
                  context: context,
                  delegate: SearchDoctorCategory(
                      doctorCategory: doctorCategory!,
                      doctorCategorySugestion: doctorCategory),
                );
                Get.back();
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: controller.obx(
        (doctorCategory) => Container(
          child: ListView.builder(
            itemCount: doctorCategory!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(doctorCategory[index].categoryName!),
                onTap: () {
                  controller.doctorCategory = doctorCategory[index];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
