import 'package:invoice_generator/model/BillingInfo.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'package:invoice_generator/model/item.dart';

class AddFormId {
  final int payload;

  AddFormId(this.payload);
}

class AddDateIssued {
  final DateTime payload;

  AddDateIssued(this.payload);
}

class AddDateDue {
  final DateTime payload;

  AddDateDue(this.payload);
}

class AddCompanyInfo {
  final BillingInfo payload;

  AddCompanyInfo(this.payload);
}

class AddCustomerInfo {
  final BillingInfo payload;

  AddCustomerInfo(this.payload);
}

class AddJobDescription {
  final String payload;

  AddJobDescription(this.payload);
}

class AddItem {
  final Item payload;

  AddItem(this.payload);
}

class RemoveItem {
  final Item payload;

  RemoveItem(this.payload);
}

class SaveInvoiceTemplate {
  final Invoice payload;
  final String name;

  SaveInvoiceTemplate(this.payload, this.name);
}

class ResetInvoice {}

class LoadAllTemplates {
  final List<Invoice> payload;

  LoadAllTemplates(this.payload);
}

class LoadInvoiceFromTemplate {
  final Invoice payload;

  LoadInvoiceFromTemplate(this.payload);
}

class DeleteInvoiceTemplate {
  final Invoice payload;

  DeleteInvoiceTemplate(this.payload);
}

class LoadSettingData {
  final Map payload;

  LoadSettingData(this.payload);
}

// Setting page actions
class SaveVAT {
  final String payload;

  SaveVAT(this.payload);
}

class SaveServiceCharge {
  final String payload;

  SaveServiceCharge(this.payload);
}

class SaveDeliveryCharge {
  final String payload;

  SaveDeliveryCharge(this.payload);
}

class SaveTerms {
  final String payload;

  SaveTerms(this.payload);
}

class SaveClientNote {
  final String payload;

  SaveClientNote(this.payload);
}

// Get Settings Info
class GetVatinfo {
  final String payload;

  GetVatinfo(this.payload);
}

class GetServiceChargeinfo {
  final String payload;

  GetServiceChargeinfo(this.payload);
}

class GetDeliveryChargeinfo {
  final String payload;

  GetDeliveryChargeinfo(this.payload);
}

class GetTermsinfo {
  final String payload;

  GetTermsinfo(this.payload);
}

class GetClientNoteinfo {
  final String payload;

  GetClientNoteinfo(this.payload);
}
