import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Doctor {
  String? id;
  @JsonKey(name: 'doctorId')
  String? doctorId;
  @JsonKey(name: 'doctorName')
  String? doctorName;
  @JsonKey(name: 'doctorPicture')
  String? doctorPicture;
  @JsonKey(name: 'doctorBasePrice')
  int? doctorPrice;
  @JsonKey(name: 'doctorBiography')
  String? doctorShortBiography;
  @JsonKey(name: 'doctorCategory')
  DoctorCategory? doctorCategory;
  @JsonKey(name: 'doctorHospital')
  String? doctorHospital;
  @JsonKey(name: 'balance')
  int? doctorBalance;
  @JsonKey(name: 'accountStatus')
  String? accountStatus;
  @JsonKey(name: 'academicQualification')
  String? academicQualification;
  @JsonKey(name: 'pastExperienceInCompany')
  String? pastExperienceInCompany;
  @JsonKey(name: 'pastExperienceInConsulting')
  String? pastExperienceInConsulting;
  @JsonKey(name: 'age')
  String? age;
  @JsonKey(name: 'recognition')
  String? recognition;
  @JsonKey(name: 'valueYouBring')
  String? valueYouBring;
  Doctor(
      {this.id,
      required this.doctorId,
      required this.doctorName,
      required this.doctorPicture,
      required this.doctorPrice,
      required this.doctorShortBiography,
      required this.doctorCategory,
      required this.doctorHospital,
      required this.doctorBalance,
      required this.accountStatus,
      this.academicQualification,
      this.pastExperienceInCompany,
      this.pastExperienceInConsulting,
      this.age,
      this.recognition,
      this.valueYouBring});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
  factory Doctor.fromFirestore(DocumentSnapshot doc) =>
      Doctor.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
