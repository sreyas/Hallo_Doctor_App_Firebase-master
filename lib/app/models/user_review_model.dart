import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_review_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UserReview {
  UserReview({this.displayName, this.photoUrl});
  String? id;
  @JsonKey(name: 'displayName')
  String? displayName;
  @JsonKey(name: 'photoUrl')
  String? photoUrl;

  factory UserReview.fromJson(Map<String, dynamic> json) =>
      _$UserReviewFromJson(json);
  Map<String, dynamic> toJson() => _$UserReviewToJson(this);
  factory UserReview.fromFirestore(DocumentSnapshot doc) =>
      UserReview.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
