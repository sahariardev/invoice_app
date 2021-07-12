import 'package:flutter/material.dart';

final Color PRIMARY_COLOR = Colors.blue[300];
final Color SECONDARY_DARK_COLOR = Colors.blueGrey[800];
final Color SECONDARY_LIGHT_COLOR = Colors.blueGrey[300];
final Color BUTTON_PRIMARY_COLOR = Colors.blue[100];

final Color BACKGROUND_COLOR = Colors.white;

final EdgeInsets FORM_FIRLD_MERGIN_INSIDE_CARD =
    EdgeInsets.only(left: 0, top: 15, right: 0, bottom: 15);

final BUTTON_SUBMIT = 'Submit';
final BUTTON_CANCEL = 'Cancel';

final CUSTOMER_ADDRESS = 'Tap to add/update Customer Address';
final COMPANY_ADDRESS = 'Tap to add/update Company Address';
final REQUIRED = 'Required';
final NAME = 'Name';
final VALIDATION_NAME = 'Please Enter Valid Name';
final ADDRESS = 'Address';
final VALIDATION_ADDRESS = 'Please Enter Valid Address';
final COUNTRY = 'Country';
final VALIDATION_COUNTRY = 'Please Enter Valid Country';
final EMAIL = 'Email';
final VALIDATION_EMAIL = 'Please Enter Valid Email';
final PHONE = 'Phone';
final VALIDATION_PHONE = 'Please Enter Valid Phone Number';
final COMPANY_INFO = 'Company Information';
final CUSTOMER_INFO = 'Customer Information';

final ITEM = 'Item';
final DESCRIPTION = 'Description';
final COST = 'Cost';
final QUANTITY = 'Quantity';
final PRICE = 'Price';
final ITEM_ADD = "Press to Add Item";
final VALIDATION_QUANTITY = 'Quantity can not be less than or equal to zero';
final TOTAL_PRICE = "Total price is ";

enum TEMPLATE {
  INVOICE,
  BILLING_INFO,
  TERMS_AND_CONDITION,
  MESSAGEe,
  VAT,
  SERVICECHARGE,
  DELIVERYCHARGE,
  TERMS,
  CLIENTNOTE
}
