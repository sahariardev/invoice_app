import 'package:invoice_generator/model/BillingInfo.dart';
import 'dart:convert';
import 'item.dart';

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
    List<Item> items = List();
    items.forEach((element) {
      items.add(new Item.fromOld(element));
    });

    return items;
  }
}
