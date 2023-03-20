import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/controllers/add_doctor_detail_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends GetView<AddDoctorDetailController> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    XFile? image;
    File? imageFile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Image'.tr,
          //style: appbarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: Text(
                'Upload a photo of yourself '.tr,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: GestureDetector(
                onTap: () async {
                  image = await _picker.pickImage(source: ImageSource.gallery);

                  if (image == null) return;
                  imageFile = File(image!.path);
                  var imageCropped = await ImageCropper().cropImage(
                      sourcePath: image!.path,
                      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                      aspectRatioPresets: [CropAspectRatioPreset.square]);
                  if (imageCropped == null) return;
                  imageFile = File(imageCropped.path);
                  controller.update();
                },
                child: GetBuilder<AddDoctorDetailController>(
                  builder: (_) {
                    if (image != null) {
                      return Image.file(
                        imageFile!,
                        height: 350,
                      );
                    } else {
                      return Image.asset('assets/images/default-profile.png');
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (imageFile == null) return;
                        controller.updateProfilePic(imageFile!);
                      },
                      child: Text(
                        'Update'.tr,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
