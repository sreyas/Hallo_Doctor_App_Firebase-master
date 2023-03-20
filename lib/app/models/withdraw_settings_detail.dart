import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdraw_settings_detail.g.dart';

@JsonSerializable()
class WithdrawSettingsDetail {
  WithdrawSettingsDetail({this.id, this.percentage = 0, this.tax = 0});
  String? id;
  @JsonKey(name: 'percentage')
  int? percentage;
  @JsonKey(name: 'tax')
  int? tax;

  factory WithdrawSettingsDetail.fromJson(Map<String, dynamic> json) =>
      _$WithdrawSettingsDetailFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawSettingsDetailToJson(this);
  factory WithdrawSettingsDetail.fromFirestore(DocumentSnapshot doc) =>
      WithdrawSettingsDetail.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;
}
