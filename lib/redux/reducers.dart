import 'package:invoice_generator/db/entity_manager.dart';
import 'package:invoice_generator/model/BillingInfo.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'package:invoice_generator/model/item.dart';
import 'package:invoice_generator/redux/app_state.dart';

import 'action.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromPrevState(prevState);

  if (action is AddFormId) {
    newState.invoice.id = action.payload;
  } else if (action is AddDateDue) {
    newState.invoice.dateDue = action.payload;
  } else if (action is AddDateIssued) {
    newState.invoice.dateIssued = action.payload;
  } else if (action is AddCompanyInfo) {
    newState.invoice.companyInfo = BillingInfo.fromOld(action.payload);
  } else if (action is AddCustomerInfo) {
    newState.invoice.customerInfo = BillingInfo.fromOld(action.payload);
  } else if (action is AddJobDescription) {
    newState.invoice.jobDescription = action.payload;
  } else if (action is AddItem) {
    List<Item> items = List();
    prevState.invoice.items.forEach((item) {
      items.add(Item.fromOld(item));
    });
    items.add(Item.fromOld(action.payload));
    newState.invoice.items = items;
  } else if (action is SaveInvoiceTemplate) {
    EntityManager em = new EntityManager();
    em.saveInvoiceTemplate(action.payload, action.name);
    em.close();
  } else if (action is ResetInvoice) {
    newState.invoice = new Invoice();
  } else if (action is DeleteInvoiceTemplate) {
    List<Invoice> oldinvoiceTemplates = newState.invoiceTemplates;
    List<Invoice> updatedList = new List();
    for (Invoice invoice in oldinvoiceTemplates) {
      if (invoice != action.payload) {
        updatedList.add(invoice);
      }
      newState.invoiceTemplates = updatedList;
    }
    EntityManager em = new EntityManager();
    em.deleteInvoiceTemplate(action.payload);
    em.close();
  } else if (action is LoadAllTemplates) {
    List<Invoice> templateList = List();
    for (Invoice invoice in action.payload) {
      templateList.add(invoice);
    }
    newState.invoiceTemplates = templateList;
  } else if (action is LoadInvoiceFromTemplate) {
    newState.invoice = Invoice.fromOld(action.payload);
  } else if (action is SaveVAT) {
    newState.vat = action.payload;

    EntityManager em = new EntityManager();
    em.saveVATInfo(action.payload);
    em.close();
  } else if (action is GetVatinfo) {
    newState.vat = action.payload;
  } else if (action is SaveServiceCharge) {
    newState.serviceCharge = action.payload;
    EntityManager em = new EntityManager();
    em.saveServiceChargeInfo(action.payload);
    em.close();
  } else if (action is GetServiceChargeinfo) {
    newState.serviceCharge = action.payload;
  } else if (action is SaveDeliveryCharge) {
    newState.deliveryCharge = action.payload;
    EntityManager em = new EntityManager();
    em.saveDeliveryChargeInfo(action.payload);
    em.close();
  } else if (action is GetDeliveryChargeinfo) {
    newState.deliveryCharge = action.payload;
  } else if (action is SaveTerms) {
    newState.terms = action.payload;
    EntityManager em = new EntityManager();
    em.saveTermsInfo(action.payload);
    em.close();
  } else if (action is GetTermsinfo) {
    newState.terms = action.payload;
  } else if (action is SaveClientNote) {
    newState.clientNote = action.payload;
    EntityManager em = new EntityManager();
    em.saveClientNoteInfo(action.payload);
    em.close();
  } else if (action is GetClientNoteinfo) {
    newState.clientNote = action.payload;
  } else if (action is LoadSettingData) {
    newState.vat = action.payload["vat"];
    newState.serviceCharge = action.payload["serviceCharge"];
    newState.deliveryCharge = action.payload["deliveryCharge"];
    newState.clientNote = action.payload["clientNote"];
    newState.terms = action.payload["terms"];
  }

  return newState;
}
