import 'file:///C:/Users/Rifat/AndroidStudioProjects/invoice_generator/lib/model/invoice.dart';

class AppState {
  Invoice _invoice;

  AppState.fromPrevState(AppState state) {
    _invoice = Invoice.fromOld(state._invoice);
  }
  AppState(){
    _invoice = new Invoice();
  }
  Invoice get invoice => _invoice;

  set invoice(Invoice value) {
    _invoice = value;
  }
}
