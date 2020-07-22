import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';

class Info extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Info"),
        ),
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (ctx, state) {
            return Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _getFormIdField(ctx, state),
                    Row(
                      children: <Widget>[
                        _datePicker(context, "Select Date Issued",
                            state.invoice.dateIssued, (DateTime dateTime) {
                          StoreProvider.of<AppState>(context)
                              .dispatch(AddDateIssued(dateTime));
                        }),
                        _datePicker(
                            context, "Select Date Due", state.invoice.dateDue,
                            (DateTime dateTime) {
                          StoreProvider.of<AppState>(context)
                              .dispatch(AddDateDue(dateTime));
                        }),
                      ],
                    ),
                    getCenterText(state)
                  ],
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.white);
  }

  Widget getCenterText(state) {
    return Text(state.invoice.id.toString());
  }

  Widget _getFormIdField(context, state) {
    if(state.invoice.id == null){
      return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            helperText: "Required",
            labelText: "Form Id"),
        keyboardType: TextInputType.datetime,
        autofocus: false,
        autovalidate: true,
        onChanged: (String val) {
          if (val.isEmpty) {
            val = "0";
          }
          StoreProvider.of<AppState>(context).dispatch(AddFormId(int.parse(val)));
        },
        validator: (String val) {
          if (val.isEmpty) {
            return "Field cannot be left blank";
          }
          return null;
        },
      );
    }
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Form Id"),
      keyboardType: TextInputType.datetime,
      initialValue: state.invoice.id.toString(),
      autofocus: false,
      autovalidate: true,
      onChanged: (String val) {
        if (val.isEmpty) {
          val = "0";
        }
        StoreProvider.of<AppState>(context).dispatch(AddFormId(int.parse(val)));
      },
      validator: (String val) {
        if (val.isEmpty) {
          return "Field cannot be left blank";
        }
        return null;
      },
    );
  }

  Widget _datePicker(BuildContext context, String pickerName,
      DateTime initialDate, Function action) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(initialDate.toString()),
        ),
        RaisedButton(
          child: Text(pickerName),
          onPressed: () =>_showCustomDatePicker(context, initialDate, action),
        )
      ],
    );
  }

  _showCustomDatePicker(
      BuildContext context, DateTime initialDate, Function action) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030));
    if (dateTime != null || dateTime != initialDate) {
      action(dateTime);
    }
  }
}
