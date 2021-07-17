import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/widget_utils.dart';
import 'package:invoice_generator/util/constants.dart';

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
              title: Text(SETTING),
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
              child: WidgetUtil.getCustomCard(
                new Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      formInfo(context, ctx, state),
                      SizedBox(height: 20),
                      WidgetUtil.getCustomButton("Save", () {
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
                      }),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white);
      },
    );
  }

  Widget formInfo(context, ctx, state) {
    return Column(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(_getVAT(ctx, state)),
        WidgetUtil.formFieldsWrapper(_getServiceCharge(ctx, state)),
        WidgetUtil.formFieldsWrapper(_getDeliveryCharge(ctx, state)),
        WidgetUtil.formFieldsWrapper(_getClientNoteForm(ctx, state)),
        WidgetUtil.formFieldsWrapper(_getTermsForm(ctx, state)),
      ],
    );
  }

  Widget _getClientNoteForm(context, state) {
    return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: CLIENT_NOTE),
        keyboardType: TextInputType.text,
        initialValue: state.clientNote,
        maxLines: 4,
        minLines: 2,
        autofocus: false,
        autovalidateMode: AutovalidateMode.disabled,
        onSaved: (String val) {
          if (val.isEmpty) {
            val = "";
          }
          clientNote = val;
        });
  }

  Widget _getTermsForm(context, state) {
    return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: TERMS),
        keyboardType: TextInputType.text,
        initialValue: state.terms,
        autofocus: false,
        autovalidateMode: AutovalidateMode.disabled,
        maxLines: 4,
        minLines: 2,
        onSaved: (String val) {
          if (val.isEmpty) {
            val = "";
          }
          terms = val;
        });
  }

  Widget _getVAT(context, state) {
    print("Get Vat");
    print(state.vat);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          VAT,
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
          SERVICE_CHARGE,
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
          DELIVERY_CHARGE,
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
          },
        )),
      ],
    );
  }
}
