// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_settings_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawSettingsDetail _$WithdrawSettingsDetailFromJson(
        Map<String, dynamic> json) =>
    WithdrawSettingsDetail(
      id: json['id'] as String?,
      percentage: json['percentage'] as int? ?? 0,
      tax: json['tax'] as int? ?? 0,
    );

Map<String, dynamic> _$WithdrawSettingsDetailToJson(
        WithdrawSettingsDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'percentage': instance.percentage,
      'tax': instance.tax,
    };
