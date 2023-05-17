import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/pages/chose_doctor_category_page.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/widgets/display_image.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';

import '../controllers/add_doctor_detail_controller.dart';




class AddDoctorDetailView extends StatelessWidget {
  final AddDoctorDetailController _adddoctorController = Get.put(AddDoctorDetailController());

  TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? _selectedValue,_selectedValueState;
  bool _showIndianStateSelection = false;
  late String state,statecode="Code";



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
          key: _adddoctorController.formkey,
          child: GetX<AddDoctorDetailController>(
            builder: (_adddoctorcontroller) => Column(
              children: [
                DisplayImage(
                    imagePath: _adddoctorcontroller.profilePicUrl.value,
                    onPressed: () {
                      _adddoctorcontroller.toEditProfilePic();
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
                  initialValue: _adddoctorcontroller.doctor == null
                      ? ''
                      : _adddoctorcontroller.doctorName.value,
                  onSaved: (name) {
                    _adddoctorcontroller.doctorName.value = name!;
                  },
                  decoration: InputDecoration(
                      hintText: _adddoctorcontroller.doctor == null
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
                  initialValue: _adddoctorcontroller.doctor == null
                      ? null
                      : _adddoctorcontroller.doctorHospital.value,
                  onSaved: (hospital) {
                    _adddoctorcontroller.doctorHospital.value = hospital!;
                  },
                  decoration: InputDecoration(
                      hintText: _adddoctorcontroller.doctor == null
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
                    _adddoctorcontroller.shortBiography.value = shortBiography!;
                  },
                  initialValue: _adddoctorcontroller.doctor == null
                      ? null
                      : _adddoctorcontroller.shortBiography.value,
                  decoration: InputDecoration(
                      hintText: _adddoctorcontroller.doctor == null
                          ? 'Short Biography'.tr
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _adddoctorcontroller.textAcademicQualificationController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Academic Qualification'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                  _adddoctorcontroller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _adddoctorcontroller.textPastExprienceInCompanyController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Past experience in Companies'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                  _adddoctorcontroller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  controller:
                  _adddoctorcontroller.textPastExprienceInConsultingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Past experience in Consulting'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                  _adddoctorcontroller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _adddoctorcontroller.textConsultingFeesController,
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
                  controller: _adddoctorcontroller.textAgeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Age',
                      helperText: 'Your Age',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _adddoctorcontroller.textRecognitionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Recognitions, Awards'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                  _adddoctorcontroller.academicQualification = value,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _adddoctorcontroller.textValueYouBringController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'What value he can add to an SME client'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                  _adddoctorcontroller.academicQualification = value,
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
                          child: Text(_adddoctorcontroller.doctorCategory == null
                              ? 'Chose Doctor Category'.tr
                              : _adddoctorcontroller.doctorCategory!.categoryName!)),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
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

                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: _db.collection('Country').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var doc = snapshot.data!.docs[index];
                                  return ListTile(
                                    title: Text(doc['name']),
                                    onTap: () {
                                      //  Navigator.pop(context, doc['name']);
                                      _selectedValue = doc['name'];
                                      if(_selectedValue != 'India'){
                                        _showIndianStateSelection = true;
                                      }else{
                                        _showIndianStateSelection = false;
                                      }
                                      Navigator.pop(context);
                                    },
                                  );

                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        );
                      },
                    ).then((_selectedValue) {
                      print(_selectedValue);
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                          child: Text(_selectedValue ?? 'Select Country')),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),

                ),
                SizedBox(height: 20),
                Visibility(
                  visible: _selectedValue == 'India',
                  child:
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Color(0xFFF5F6F9),

                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: _db.collection('State').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var doc = snapshot.data!.docs[index];
                                    return ListTile(
                                      title: Text(doc['name']),
                                      onTap: () {
                                        //  Navigator.pop(context, doc['name']);
                                        _selectedValueState = doc['name'];

                                        Navigator.pop(context);
                                      },
                                    );

                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          );
                        },
                      ).then((_selectedValueState) {

                        print(_selectedValueState);
                      });
                    },

                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(_selectedValueState ?? 'Select State')),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),),
                SizedBox(height: 20),
                Visibility(
                  visible: _showIndianStateSelection,
                  child:
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter State'.tr),
                    maxLines: 1,
                    textInputAction: TextInputAction.done,

                  ),),
                SizedBox(height: 20),


                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Do You have Gst Number:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    RadioListTile(
                      title: Text('Yes'),
                      value: 0,
                      groupValue: _adddoctorcontroller.selectedRadio.value,
                      onChanged: (int? value) {
                        _adddoctorcontroller.handleRadioValueChange(value);
                      },
                    ),
                    RadioListTile(
                      title: Text('No'),
                      value: 1,
                      groupValue: _adddoctorcontroller.selectedRadio.value,
                      onChanged: (int? value) {
                        _adddoctorcontroller.handleRadioValueChange(value);
                      },
                    ),
                  ],
                )),



                SizedBox(height: 20),
            Visibility(
              visible: _adddoctorcontroller.selectedRadio.value.isEqual(0),
              child:
                TextField(
                  controller: _adddoctorcontroller.textgstnoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'GST'.tr),
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                  _adddoctorcontroller.gstno = value,

                ),),
                SizedBox(height: 20),
                TextField(
                  controller: _adddoctorcontroller.textaddressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Address'.tr),
                  maxLines: 5,
                  textInputAction: TextInputAction.done,



                ),
                SizedBox(height: 20),
                TextField(
                  controller: _adddoctorcontroller.textpanController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'PAN'.tr),
                  maxLines: 1,
                  textInputAction: TextInputAction.done,



                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _adddoctorcontroller.textmobileController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Mobile'.tr),
                  maxLines: 1,
                  textInputAction: TextInputAction.done,



                ),
                Divider(
                  height: 40,
                ),
                submitButton(
                    onTap: ()  async {
                      if(_selectedValue=="India"){
                        state=_selectedValueState!;
                        var languageSettingVersionRef = await FirebaseFirestore.instance
                            .collection('State').where('name', isEqualTo: state)
                            .get();
                        for (var snapshot in languageSettingVersionRef.docs) {
                          if(snapshot.exists){
                            Map<String, dynamic> data = snapshot.data();
                            statecode = data['code'];
                          }else{
                            statecode = "CODE";
                          }

                        }
                      }else{
                        state=_textController.text;
                      }
                      _adddoctorcontroller.saveDoctorDetail(_selectedValue!,state!,statecode!);
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

