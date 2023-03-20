// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel()
  ..doctorId = json['doctorId'] as String?
  ..timeSlotId = json['timeSlotId'] as String?
  ..review = json['review'] as String?
  ..rating = json['rating'] as double?
  ..userReview = json['user'] == null
      ? null
      : UserReview.fromJson(json['user'] as Map<String, dynamic>)
  ..userId = json['userId'] as String?;

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'timeSlotId': instance.timeSlotId,
      'review': instance.review,
      'rating': instance.rating,
      'user': instance.userReview,
      'userId': instance.userId,
    };
