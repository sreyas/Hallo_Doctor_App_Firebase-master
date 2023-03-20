import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';

import '../../../../styles/styles.dart';
import '../../controllers/edit_profile_controller.dart';

class ChangeBasePrice extends GetView<EditProfileController> {
  const ChangeBasePrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Change Base Price'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.textEditingBasePriceController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'Base Price',
                  helperText: 'Your Base Booking Price',
                  labelText: 'Base Price',
                  prefixText: ' ',
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  controller.saveBasePrice();
                },
                child: Text('Save'.tr),
                style: ElevatedButton.styleFrom(fixedSize: Size(340, 40)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
