// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BillingInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingInfo _$BillingInfoFromJson(Map<String, dynamic> json) {
  return BillingInfo()
    ..name = json['name'] as String
    ..country = json['country'] as String
    ..phone = json['phone'] as String
    ..email = json['email'] as String
    ..address = json['address'] as String;
}

Map<String, dynamic> _$BillingInfoToJson(BillingInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
    };
