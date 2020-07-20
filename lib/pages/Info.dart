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
        if(val.isEmpty){
          val="0";
        }
        StoreProvider.of<AppState>(context).dispatch(FormId(int.parse(val)));
      },
      validator: (String val) {
        if (val.isEmpty) {
          return "Field cannot be left blank";
        }
        return null;
      },
    );
  }
}
