import 'package:invoice_generator/model/BillingInfo.dart';
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
  }

  return newState;
}
