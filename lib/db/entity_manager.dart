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

  Future<String> getVATInfo() async {
    Database db = await getDB();
    final vatInfo = await db.query("map",
        columns: null, where: "key = ?", whereArgs: [TEMPLATE.VAT.toString()]);

    if (vatInfo.length > 0) {
      return vatInfo.first["value"];
    } else {
      return null;
    }
  }

  Future<String> getServiceChargeInfo() async {
    Database db = await getDB();
    final serviceChargeInfo = await db.query("map",
        columns: null, where: "key = ?", whereArgs: [TEMPLATE.SERVICECHARGE.toString()]);

    if (serviceChargeInfo.length == 1) {
      return serviceChargeInfo.first["value"];
    } else {
      return null;
    }
  }

  Future<String> getDeliveryChargeInfo() async {
    Database db = await getDB();
    final deliveryChargeInfo = await db.query("map",
        columns: null, where: "key = ?", whereArgs: [TEMPLATE.DELIVERYCHARGE.toString()]);

    if (deliveryChargeInfo.length == 1) {
      return deliveryChargeInfo.first["value"];
    } else {
      return null;
    }
  }

  Future<String> getTermsInfo() async {
    Database db = await getDB();
    final termsInfo = await db.query("map",
        columns: null, where: "key = ?", whereArgs: [TEMPLATE.TERMS.toString()]);

    if (termsInfo.length == 1) {
      return termsInfo.first["value"];
    } else {
      return null;
    }
  }

  Future<String> getClientNoteInfo() async {
    Database db = await getDB();
    final clientNoteInfo = await db.query("map",
        columns: null, where: "key = ?", whereArgs: [TEMPLATE.CLIENTNOTE.toString()]);

    if (clientNoteInfo.length == 1) {
      return clientNoteInfo.first["value"];
    } else {
      return null;
    }
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

  saveVATInfo(String VAT) async {
    print(VAT);
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.VAT.toString(),
      "key": TEMPLATE.VAT.toString(),
      "value": VAT,
      "extra": "c"
    });
  }

  saveServiceChargeInfo(String serviceCharge) async {
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.SERVICECHARGE.toString(),
      "key": TEMPLATE.SERVICECHARGE.toString(),
      "value": serviceCharge,
      "extra": "c"
    });
  }

  saveDeliveryChargeInfo(String deliveryCharge) async {
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.DELIVERYCHARGE.toString(),
      "key": TEMPLATE.DELIVERYCHARGE.toString(),
      "value": deliveryCharge,
      "extra": "c"
    });
  }

  saveTermsInfo(String terms) async {
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.TERMS.toString(),
      "key": TEMPLATE.TERMS.toString(),
      "value": terms,
      "extra": "c"
    });
  }

  saveClientNoteInfo(String clientNote) async {
    Database db = await getDB();
    db.insert("map", {
      "type": TEMPLATE.CLIENTNOTE.toString(),
      "key": TEMPLATE.CLIENTNOTE.toString(),
      "value": clientNote,
      "extra": "c"
    });
  }

  close() {
    if (_db != null) {
      _db.close();
    }
  }
}
