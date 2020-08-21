// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item()
    ..qty = json['qty'] as int
    ..cost = json['cost'] as int
    ..description = json['description'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'qty': instance.qty,
      'cost': instance.cost,
      'description': instance.description,
      'name': instance.name,
    };
