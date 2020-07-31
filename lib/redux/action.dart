import 'package:invoice_generator/model/BillingInfo.dart';
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


class AddCompanyInfo{
  final BillingInfo payload;
  AddCompanyInfo(this.payload);
}

class AddCustomerInfo {
  final BillingInfo payload;

  AddCustomerInfo(this.payload);
}
class AddJobDescription{
  final String payload;
  AddJobDescription(this.payload);
}

class AddItem {
  final Item payload;
  AddItem(this.payload);
}