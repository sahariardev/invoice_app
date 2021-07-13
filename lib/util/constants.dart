import 'package:flutter/material.dart';

final Color PRIMARY_COLOR = Colors.blue[300];
final Color SECONDARY_DARK_COLOR = Colors.blueGrey[800];
final Color SECONDARY_LIGHT_COLOR = Colors.blueGrey[300];
final Color BUTTON_PRIMARY_COLOR = Colors.blue[100];

const Color BACKGROUND_COLOR = Colors.white;

const EdgeInsets FORM_FIRLD_MERGIN_INSIDE_CARD =
    EdgeInsets.only(left: 0, top: 15, right: 0, bottom: 15);

const BUTTON_SUBMIT = 'Submit';
const BUTTON_CANCEL = 'Cancel';
const REQUIRED = 'Required';

// Customer Page
const CUSTOMER_ADDRESS = 'Tap to add/update Customer Address';
const COMPANY_ADDRESS = 'Tap to add/update Company Address';
const NAME = 'Name';
const VALIDATION_NAME = 'Please Enter Valid Name';
const ADDRESS = 'Address';
const VALIDATION_ADDRESS = 'Please Enter Valid Address';
const COUNTRY = 'Country';
const VALIDATION_COUNTRY = 'Please Enter Valid Country';
const EMAIL = 'Email';
const VALIDATION_EMAIL = 'Please Enter Valid Email';
const PHONE = 'Phone';
const VALIDATION_PHONE = 'Please Enter Valid Phone Number';
const COMPANY_INFO = 'Company Information';
const CUSTOMER_INFO = 'Customer Information';

// Item Page
const ITEM = 'Item';
const DESCRIPTION = 'Description';
const COST = 'Cost';
const QUANTITY = 'Quantity';
const PRICE = 'Price';
const ITEM_ADD = "Press to Add Item";
const VALIDATION_QUANTITY = 'Quantity can not be less than or equal to zero';
const TOTAL_PRICE = "Total price is ";

// Preview Page
const SUMMARY = 'Summary';
const DOWNLOAD_INVOICE = 'Download Invoice';
const SAVE_TEMPLATE = 'Save As Template';
const TEMPLATE_NAME = 'Template Name';
const FORM_ID = 'Form ID';
const CUSTOMER_NAME = 'Customer Name';
const COMPANY_NAME = 'Company Name';
const TOTAL_ITEM = 'Total Items';
const DUE_DATE = 'Due Date';
const VAT = 'VAT';
const SERVICE_CHARGE = 'Service Charge';
const DELIVERY_CHARGE = 'Delivery Charge';

// Setting Page
const SETTING = 'Setting';
const SAVE = 'Save';
const CLIENT_NOTE = 'Client Notes';
const TERMS = 'Terms & Conditions';

// Info Page
const INFO = 'Info';
const INVOICE_RESET = 'Reset Invoice';
const LOAD_TEMPLATE = 'Load From Template';
const DATE_ISSUED = 'Select Date Issued';
const DATE_DUE = 'Select Due Date';
const FIELD_VALIDATION = 'Field cannot be left blank';
const JOB_DESC = 'Job Description';
const INVOICE_TEMP = 'Invoice Templates';
const NO_TEMP = 'No Template Available';

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
