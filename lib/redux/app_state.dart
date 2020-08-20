
import 'package:invoice_generator/model/invoice.dart';

class AppState {
  Invoice _invoice;
  List<Invoice> _invoiceTemplates;

  AppState.fromPrevState(AppState state) {
    _invoice = Invoice.fromOld(state._invoice);
    _invoiceTemplates = new List();
    
    for(Invoice invoice in state._invoiceTemplates){
      _invoiceTemplates.add(Invoice.fromOld(invoice));
    }
  }
  AppState(){
    _invoice = new Invoice();
    _invoiceTemplates = new List();
  }
  Invoice get invoice => _invoice;

  set invoice(Invoice value) {
    _invoice = value;
  }

  List<Invoice> get invoiceTemplates => _invoiceTemplates;

  set invoiceTemplates(List<Invoice> value) {
    _invoiceTemplates = value;
  }
}
