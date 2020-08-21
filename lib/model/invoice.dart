import 'package:invoice_generator/model/BillingInfo.dart';
import 'item.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:json_annotation/json_annotation.dart';
part 'invoice.g.dart';
@JsonSerializable(nullable: false)
class Invoice {
  int _id;
  String _templateName= "";
  DateTime _dateIssued = DateTime.now();

  DateTime _dateDue = DateTime.now();

  String _jobDescription;

  BillingInfo _companyInfo;

  BillingInfo _customerInfo;

  List<Item> _items = List();

  Invoice() {
  }

  Invoice.fromOld(Invoice old) {
    _id = old.id;
    _dateIssued = old.dateIssued;
    _dateDue = old.dateDue;
    _jobDescription = old.jobDescription;
    _companyInfo = BillingInfo.fromOld(old.companyInfo);
    _customerInfo = BillingInfo.fromOld(old.customerInfo);
    _items = _getItemsFromOld(old.items);
  }

  Invoice.fromJSON(Map<String, dynamic> json){
    _companyInfo = BillingInfo.fromJSON(json["companyInfo"]);
    _customerInfo = BillingInfo.fromJSON(json["customerInfo"]);

    List i = json["items"];
    i.forEach((element) {
      _items.add(Item.fromJSON(element));
    });
  }

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  DateTime get dateIssued => _dateIssued;

  String get jobDescription => _jobDescription;

  set jobDescription(String value) {
    _jobDescription = value;
  }

  DateTime get dateDue => _dateDue;

  set dateDue(DateTime value) {
    _dateDue = value;
  }

  set dateIssued(DateTime value) {
    _dateIssued = value;
  }

  BillingInfo get companyInfo => _companyInfo;

  set companyInfo(BillingInfo value) {
    _companyInfo = value;
  }

  BillingInfo get customerInfo => _customerInfo;

  set customerInfo(BillingInfo value) {
    _customerInfo = value;
  }

  get items => _items;

  set items(value) {
    _items = value;
  }

  List<Item> _getItemsFromOld(items) {
    List<Item> new_items = List();
    items.forEach((element) {
      new_items.add(new Item.fromOld(element));
    });

    return new_items;
  }

  getTotal() {
    int sum = 0;
    for (Item item in items) {
      sum += item.total;
      return sum;
    }
  }

  String get templateName => _templateName;

  set templateName(String value) {
    _templateName = value;
  }

  @override
  String toString() {
    return 'Invoice{_id: $_id, _templateName: $_templateName, _dateIssued: $_dateIssued, _dateDue: $_dateDue, _jobDescription: $_jobDescription, _companyInfo: $_companyInfo, _customerInfo: $_customerInfo, _items: $_items}';
  }
}
