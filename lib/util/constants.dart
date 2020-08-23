import 'package:flutter/material.dart';

final Color PRIMARY_COLOR = Colors.blueGrey[500];
final Color SECONDARY_DARK_COLOR = Colors.blueGrey[800];
final Color SECONDARY_LIGHT_COLOR = Colors.blueGrey[300];
final Color BUTTON_PRIMARY_COLOR = Colors.amber[900];

final Color BACKGROUND_COLOR = Colors.white;

final EdgeInsets FORM_FIRLD_MERGIN_INSIDE_CARD =
    EdgeInsets.only(left: 0, top: 15, right: 0, bottom: 15);


enum TEMPLATE {
  INVOICE,
  BILLING_INFO,
  TERMS_AND_CONDITION,
  MESSAGEe
}