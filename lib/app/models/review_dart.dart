import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/user_review_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review_dart.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ReviewModel {
  String? id;
  @JsonKey(name: 'doctorId')
  String? doctorId;
  @JsonKey(name: 'timeSlotId')
  String? timeSlotId;
  @JsonKey(name: 'review')
  String? review;
  @JsonKey(name: 'rating')
  double? rating;
  @JsonKey(name: 'user')
  UserReview? userReview;
  @JsonKey(name: 'userId')
  String? userId;
  ReviewModel({this.id});
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
  factory ReviewModel.fromFirestore(DocumentSnapshot doc) =>
      ReviewModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
