import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/animation/FadeAnimation.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/widget_utils.dart';
import 'package:flutter/services.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingState();
  }
}
class SettingState extends State<Setting> {
  final _formKey = GlobalKey<FormState>();
  String vat = '';
  String serviceCharge = '';
  String deliveryCharge = '';
  String clientNote = '';
  String terms = '';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (ctx, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text("Setting"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    formInfo(context, ctx, state),
                    SizedBox(height: 20),
                    RaisedButton(
                        onPressed: () {
                          //validate
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            StoreProvider.of<AppState>(context)
                                .dispatch(SaveVAT(vat));
                            StoreProvider.of<AppState>(context)
                                .dispatch(SaveServiceCharge(serviceCharge));
                            StoreProvider.of<AppState>(context)
                                .dispatch(SaveDeliveryCharge(deliveryCharge));
                            StoreProvider.of<AppState>(context)
                                .dispatch(SaveClientNote(clientNote));
                            StoreProvider.of<AppState>(context)
                                .dispatch(SaveTerms(terms));
                          }
                        },
                        child: Text("Save"))
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white);
      },
    );
  }

  Widget formInfo(context, ctx, state) {
    return WidgetUtil.getCustomCard(new Column(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(FadeAnimation(1, _getVAT(ctx, state))),
        WidgetUtil.formFieldsWrapper(
            FadeAnimation(1.2, _getServiceCharge(ctx, state))),
        WidgetUtil.formFieldsWrapper(
            FadeAnimation(1.5, _getDeliveryCharge(ctx, state))),
        WidgetUtil.formFieldsWrapper(
            FadeAnimation(1.8, _getClientNoteForm(ctx, state))),
        WidgetUtil.formFieldsWrapper(
            FadeAnimation(2, _getTermsForm(ctx, state))),
      ],
    ));
  }

  Widget _getClientNoteForm(context, state) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Client Notes"),
      keyboardType: TextInputType.text,
      initialValue: state.clientNote,
      maxLines: 4,
      minLines: 2,
      autofocus: false,
      autovalidate: false,
      onSaved: (String val) {
        if (val.isEmpty) {
          val = "0";
        }
//        StoreProvider.of<AppState>(context).dispatch(AddFormId(int.parse(val)));
//        StoreProvider.of<AppState>(context).dispatch(SaveClientNote(val));
        clientNote = val;
      },
      validator: (String val) {
        if (val.isEmpty) {
          return "Field cannot be left blank";
        }
        return null;
      },
    );
  }

  Widget _getTermsForm(context, state) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Terms & Conditions"),
      keyboardType: TextInputType.text,
      initialValue: state.terms,
      autofocus: false,
      autovalidate: false,
      maxLines: 4,
      minLines: 2,
      onSaved: (String val) {
        if (val.isEmpty) {
          val = "";
        }
//        StoreProvider.of<AppState>(context).dispatch(AddJobDescription(val));
//        StoreProvider.of<AppState>(context).dispatch(SaveTerms(val));
        terms = val;
      },
      validator: (String val) {
        if (val.isEmpty) {
          return "Field cannot be left blank";
        }
        return null;
      },
    );
  }

  Widget _getVAT(context, state) {
    print("Get Vat");
    print(state.vat);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "VAT",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          // Only numbers can be entered
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
          initialValue: state.vat,
          onSaved: (String val) {
            if (val.isEmpty) {
              val = '';
            }
            vat = val;
//            StoreProvider.of<AppState>(context).dispatch(SaveVAT(val));
          },
        )),
      ],
    );
  }

  Widget _getServiceCharge(context, state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Service Charge",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
          initialValue: state.serviceCharge,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          // Only numbers can be entered
          onSaved: (String val) {
            if (val.isEmpty) {
              val = "";
            }
            serviceCharge = val;
//            StoreProvider.of<AppState>(context).dispatch(AddJobDescription(val));
//            StoreProvider.of<AppState>(context)
//                .dispatch(SaveServiceCharge(val));
          },
        )),
      ],
    );
  }

  Widget _getDeliveryCharge(context, state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Delivery Charge",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          // Only numbers can be entered
          initialValue: state.deliveryCharge,
          onSaved: (String val) {
            if (val.isEmpty) {
              val = "";
            }

            deliveryCharge = val;
//            StoreProvider.of<AppState>(context).dispatch(AddJobDescription(val));
//            StoreProvider.of<AppState>(context)
//                .dispatch(SaveDeliveryCharge(val));
          },
        )),
      ],
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
        ),
      ],
    );
  }
}
