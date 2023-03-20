import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_category.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class DoctorCategory {
  String? id;
  @JsonKey(name: 'categoryId')
  String? categoryId;
  @JsonKey(name: 'categoryName')
  String? categoryName;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  DoctorCategory({this.id});
  factory DoctorCategory.fromJson(Map<String, dynamic> json) =>
      _$DoctorCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorCategoryToJson(this);
  factory DoctorCategory.fromFirestore(DocumentSnapshot doc) =>
      DoctorCategory.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
