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
  }

  return newState;
}
