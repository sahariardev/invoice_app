
import 'package:invoice_generator/model/invoice.dart';

class AppState {
  Invoice _invoice;
  List<Invoice> _invoiceTemplates;
  String _vat;
  String _serviceCharge;
  String _deliveryCharge;
  String _terms;
  String _clientNote;

  String get terms => _terms;

  set terms(String value) {
    _terms = value;
  }

  String get clientNote => _clientNote;

  set clientNote(String value) {
    _clientNote = value;
  }

  String get deliveryCharge => _deliveryCharge;

  set deliveryCharge(String value) {
    _deliveryCharge = value;
  }

  String get serviceCharge => _serviceCharge;

  set serviceCharge(String value) {
    _serviceCharge = value;
  }

  String get vat => _vat;

  set vat(String value) {
    _vat = value;
  }

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
