import 'dart:convert';
import 'dart:io';

import 'package:invoice_generator/model/BillingInfo.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'package:invoice_generator/util/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EntityManager {
  Database _db;

  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "invoice_manager.db");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database newDB, int version) {
      newDB.execute("""
            CREATE TABLE map (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             type TEXT,
             key TEXT,
             value TEXT ,
             extra TEXT 
            ) 
          """);
    });
  }

  Future<Database> getDB() async {
    if (_db == null) {
      await init();
    }

    return _db;
  }

  saveInvoiceTemplate(Invoice invoice, String templateName) async {
    invoice.templateName = templateName;
    String json = jsonEncode(invoice);
    print(json);
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.INVOICE.toString(),
      "key": templateName,
      "value": json,
      "extra": "NA"
    });
  }

  deleteInvoiceTemplate(Invoice invoice) async {
    Database db = await getDB();
    db.delete("map", where: "key = ?", whereArgs: [invoice.templateName]);
  }

  Future<List<Invoice>>getAllInvoiceTemplates() async {
    Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('map',
        columns: null,
        where: "type = ?",
        whereArgs: [TEMPLATE.INVOICE.toString()]);

    List<Invoice> list =  List.generate(maps.length, (index)  {
      return Invoice.fromJson(json.decode(maps[index]['value']));
    });
    return list;
  }

  Future<Invoice> getInvoiceTemplate(String templateName) async {
    Database db = await getDB();
    final invoiceTemplates = await db.query("map",
        columns: null, where: "key = ?", whereArgs: [templateName]);

    if (invoiceTemplates.length == 1) {
      return Invoice.fromJSON(json.decode(invoiceTemplates.first["value"]));
    } else {
      return null;
    }
  }

  saveBillingInfoTemplate(BillingInfo billingInfo, String templateName) async {
    String json = jsonEncode(billingInfo);
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.BILLING_INFO.toString(),
      "key": templateName,
      "value": json,
      "extra": "NA"
    });
  }

  saveCompanyBillingInfoTemplate(
      BillingInfo billingInfo, String templateName) async {
    String json = jsonEncode(billingInfo);
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.BILLING_INFO.toString(),
      "key": templateName,
      "value": json,
      "extra": "c"
    });
  }

  close() {
    if (_db != null) {
      _db.close();
    }
  }
}
