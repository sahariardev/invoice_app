// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice()
    ..templateName = json['templateName'] as String
    ..id = json['id'] as int
    ..dateIssued = DateTime.parse(json['dateIssued'] as String)
    ..jobDescription = json['jobDescription'] as String
    ..dateDue = DateTime.parse(json['dateDue'] as String)
    ..companyInfo =
        BillingInfo.fromJson(json['companyInfo'] as Map<String, dynamic>)
    ..customerInfo =
        BillingInfo.fromJson(json['customerInfo'] as Map<String, dynamic>)
    ..items = Item.fromJsonList(json['items']);
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'templateName': instance.templateName,
      'id': instance.id,
      'dateIssued': instance.dateIssued.toIso8601String(),
      'jobDescription': instance.jobDescription,
      'dateDue': instance.dateDue.toIso8601String(),
      'companyInfo': instance.companyInfo,
      'customerInfo': instance.customerInfo,
      'items': instance.items,
    };
