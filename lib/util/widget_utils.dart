import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class WidgetUtil {
  static Widget getCustomCard(Widget child) {
    return Container(
        child: child,
        margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
        padding: EdgeInsets.only(left: 15, top: 30, right: 15, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ));
    }

    static Widget getCustomButton(String buttonName, VoidCallback callback){
      return RaisedButton(
        onPressed: callback,
        color: Colors.amber[900],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black)
        ),
        child: Container(
          height: 50,
          width: 120,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(buttonName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
        ),
      );
    }

  static Widget formFieldsWrapper(Widget child) {
    return Container(
      margin: FORM_FIRLD_MERGIN_INSIDE_CARD,
      child: child,
    );
  }

  static String getFormattedDate(DateTime date) {
    return new DateFormat('yyyy-MM-dd').format(date);
  }

  static TableRow inputLabelAsTableRpw(String label, Widget value) {
    return TableRow(
      children: [
        tableWidthContainer(Text(label,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        tableWidthContainer(Text(":")),
        tableWidthContainer(value)
      ]
    );
  }

  static Widget tableWidthContainer(Widget child){
    return Container(
      margin:  EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
      child: child,
    );
  }
  static Widget placeHolderText(String text){
    return Text(
      text,
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black12)
    );
  }

  static Widget placeHolderTextForAddress(){
    return placeHolderText("Tap to add");
  }

}
