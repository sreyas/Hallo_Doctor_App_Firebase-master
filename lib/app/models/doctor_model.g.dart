// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      doctorPicture: json['doctorPicture'] as String?,
      doctorPrice: json['doctorBasePrice'] as int?,
      doctorShortBiography: json['doctorBiography'] as String?,
      doctorCategory: json['doctorCategory'] == null
          ? null
          : DoctorCategory.fromJson(
              json['doctorCategory'] as Map<String, dynamic>),
      doctorHospital: json['doctorHospital'] as String?,
      doctorBalance: json['balance'] as double?,
      accountStatus: json['accountStatus'] as String?,
      academicQualification: json['academicQualification'] as String?,
      pastExperienceInCompany: json['pastExperienceInCompany'] as String?,
      pastExperienceInConsulting: json['pastExperienceInConsulting'] as String?,
      age: json['age'] as String?,
      recognition: json['recognition'] as String?,
      valueYouBring: json['valueYouBring'] as String?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'doctorPicture': instance.doctorPicture,
      'doctorBasePrice': instance.doctorPrice,
      'doctorBiography': instance.doctorShortBiography,
      'doctorCategory': instance.doctorCategory,
      'doctorHospital': instance.doctorHospital,
      'balance': instance.doctorBalance,
      'accountStatus': instance.accountStatus,
      'academicQualification': instance.academicQualification,
      'pastExperienceInCompany': instance.pastExperienceInCompany,
      'pastExperienceInConsulting': instance.pastExperienceInConsulting,
      'age': instance.age,
      'recognition': instance.recognition,
      'valueYouBring': instance.valueYouBring,
    };
