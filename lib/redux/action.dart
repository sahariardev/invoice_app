import 'package:invoice_generator/model/BillingInfo.dart';

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

class AddCompanyInfo{
  final BillingInfo payload;
  AddCompanyInfo(this.payload);
}

class AddCustomerInfo{
  final BillingInfo payload;
  AddCustomerInfo(this.payload);
}