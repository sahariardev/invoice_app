import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/widget_utils.dart';

import 'Customer.dart';

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
                    formInfo(context, ctx, state),
                    customerInfo(),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.white);
  }

  Widget formInfo(context, ctx, state) {
    return WidgetUtil.getCustomCard(new Column(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(_getFormIdField(ctx, state)),
        WidgetUtil.formFieldsWrapper(
            _datePicker(context, "Select Date Issued", state.invoice.dateIssued,
                (DateTime dateTime) {
          StoreProvider.of<AppState>(context).dispatch(AddDateIssued(dateTime));
        })),
        WidgetUtil.formFieldsWrapper(
            _datePicker(context, "Select Due Date", state.invoice.dateDue,
                (DateTime dateTime) {
          StoreProvider.of<AppState>(context).dispatch(AddDateDue(dateTime));
        })),
        WidgetUtil.formFieldsWrapper(_getJobDescriptionForm(ctx, state)),
      ],
    ));
  }

  Widget customerInfo() {
    return WidgetUtil.getCustomCard(Customer());
  }

  Widget getCenterText(state) {
    return Text(state.invoice.id.toString());
  }

  Widget _getFormIdField(context, state) {
    if (state.invoice.id == null) {
      return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            helperText: "Required",
            labelText: "Form Id"),
        keyboardType: TextInputType.number,
        autofocus: false,
        autovalidate: false,
        onChanged: (String val) {
          if (val.isEmpty) {
            val = "0";
          }
          StoreProvider.of<AppState>(context)
              .dispatch(AddFormId(int.parse(val)));
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
      keyboardType: TextInputType.number,
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
          child: Text(WidgetUtil.getFormattedDate(initialDate)),
        ),
//        RaisedButton(
//          color: Colors.orange[900],
//          child: Text(pickerName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//          onPressed: () => _showCustomDatePicker(context, initialDate, action),
//        ),
        const SizedBox(height: 10),
        RaisedButton(
          onPressed: () => _showCustomDatePicker(context, initialDate, action),
          color: Colors.amber[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)
          ),
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(pickerName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
        ),
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

    if(dateTime == null){
      action(initialDate);
    }

  }

  Widget _getJobDescriptionForm(context, state) {
    if (state.invoice.jobDescription == null) {
      return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            helperText: "Required",
            labelText: "Job Description"),
        keyboardType: TextInputType.text,
        autofocus: false,
        autovalidate: false,
        maxLines: 3,
        onChanged: (String val) {
          if (val.isEmpty) {
            val = "";
          }
          StoreProvider.of<AppState>(context).dispatch(AddJobDescription(val));
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
          labelText: "Job Description"),
      keyboardType: TextInputType.text,
      initialValue: state.invoice.jobDescription,
      autofocus: false,
      autovalidate: true,
      onChanged: (String val) {
        if (val.isEmpty) {
          val = "";
        }
        StoreProvider.of<AppState>(context).dispatch(AddJobDescription(val));
      },
      validator: (String val) {
        if (val.isEmpty) {
          return "Field cannot be left blank";
        }
        return null;
      },
    );
  }

  Widget _getJobDescription(state) {
    return state.invoice.jobDescription != null
        ? Text(state.invoice.jobDescription)
        : Container();
  }
}
