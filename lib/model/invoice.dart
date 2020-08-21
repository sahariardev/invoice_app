import 'package:invoice_generator/model/BillingInfo.dart';
import 'item.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Invoice {
  int _id;

  DateTime _dateIssued = DateTime.now();

  DateTime _dateDue = DateTime.now();

  String _jobDescription;

  BillingInfo _companyInfo;

  BillingInfo _customerInfo;

  List<Item> _items = List();

  Invoice() {}

  Invoice.fromOld(Invoice old) {
    _id = old.id;
    _dateIssued = old.dateIssued;
    _dateDue = old.dateDue;
    _jobDescription = old.jobDescription;
    _companyInfo = BillingInfo.fromOld(old.companyInfo);
    _customerInfo = BillingInfo.fromOld(old.customerInfo);
    _items = _getItemsFromOld(old.items);
  }

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

  @override
  String toString() {
    return 'Invoice{_id: $_id, _dateIssued: $_dateIssued, _dateDued: $_dateDue, _jobDescription: $_jobDescription}';
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
}
