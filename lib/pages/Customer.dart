import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/model/BillingInfo.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/widget_utils.dart';

class Customer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CustomerState();
  }
}

class CustomerState extends State<Customer> {
  final _formKey = GlobalKey<FormState>();
  EdgeInsets customerCardPadding = EdgeInsets.fromLTRB(0, 30, 0, 30);

  BillingInfo customerInfo = new BillingInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Container(
          child: Column(
            children: <Widget>[
              WidgetUtil.formFieldsWrapper(addressWidget(
                  state, "Tap to add/update Customer Address", 0, () {
                _openAddressDialog(context, state, 0);
              })),
              WidgetUtil.formFieldsWrapper(addressWidget(
                  state, "Tap to add/update Company Address", 1, () {
                _openAddressDialog(context, state, 1);
              }))
            ],
          ),
        );
      },
    ));
  }

  Widget addressWidget(state, String message, type, Function action) {
    return GestureDetector(
      child: Column(
        children: <Widget>[addressCard(message, getAddressDetail(state, type))],
      ),
      onTap: action,
    );
  }

  _openAddressDialog(stateContext, state, type) {
    showDialog(
        context: stateContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Address'),
            content: Form(
              key: _formKey,
              child: Container(
                height: (MediaQuery.of(context).size.height) / 3,
                child: getModalFormFields(stateContext, state, type),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Submit"),
                onPressed: () {
                  //validate
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pop();
                    if (type == 0) {
                      StoreProvider.of<AppState>(stateContext)
                          .dispatch(AddCustomerInfo(customerInfo));
                    } else {
                      StoreProvider.of<AppState>(stateContext)
                          .dispatch(AddCompanyInfo(customerInfo));
                    }
                  }
                },
              )
            ],
          );
        });
  }

  Widget getModalFormFields(context, state, type) {
    String nameInitialValue = "";
    String addressInitialValue = "";
    String countryInitialValue = "";
    String emailInitialValue = "";
    String phoneInitialValue = "";

    if (type == 0) {
      if (state.invoice.customerInfo != null) {
        nameInitialValue = state.invoice.customerInfo.name;
        addressInitialValue = state.invoice.customerInfo.address;
        countryInitialValue = state.invoice.customerInfo.country;
        emailInitialValue = state.invoice.customerInfo.email;
        phoneInitialValue = state.invoice.customerInfo.phone;
      }
    } else {
      if (state.invoice.companyInfo != null) {
        nameInitialValue = state.invoice.companyInfo.name;
        addressInitialValue = state.invoice.companyInfo.address;
        countryInitialValue = state.invoice.companyInfo.country;
        emailInitialValue = state.invoice.companyInfo.email;
        phoneInitialValue = state.invoice.companyInfo.phone;
      }
    }

    return ListView(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(
            getName(nameInitialValue, (val) {
          customerInfo.name = val;
        })),
        WidgetUtil.formFieldsWrapper(
            getAddress(addressInitialValue, (val) {
          customerInfo.address = val;
        })),
        WidgetUtil.formFieldsWrapper(
            getCountry(countryInitialValue, (val) {
              customerInfo.country = val;
            })),
        WidgetUtil.formFieldsWrapper(
            getEmail(emailInitialValue, (val) {
          customerInfo.email = val;
        })),
        WidgetUtil.formFieldsWrapper(
            getPhone(phoneInitialValue, (val) {
          customerInfo.phone = val;
        }))
      ],
    );
  }

  Widget getName(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Name"),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 3) {
          return "Please enter a valid name";
        }
        return null;
      },
    );
  }

  Widget getAddress(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Address"),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 3) {
          return "Please enter a valid address";
        }
        return null;
      },
    );
  }

  Widget getCountry(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Country"),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 2) {
          return "Please enter a valid country";
        }
        return null;
      },
    );
  }

  Widget getEmail(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Email"),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (!val.contains("@")) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }

  Widget getPhone(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Phone"),
      autofocus: false,
      autovalidate: false,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 7) {
          return "Please enter a valid phone number";
        }
        return null;
      },
    );
  }

  Widget addressCard(message, Widget addressDetail) {
    return Column(
      children: <Widget>[
        addressDetail,
        Center(
          child: Padding(
              padding: customerCardPadding,
              child: Text(
                message,
                style: TextStyle(color: Colors.black.withOpacity(0.3)),
              )),
        )
      ],
    );
  }

  Widget getAddressDetail(state, type) {
    BillingInfo info = state.invoice.companyInfo;
    String cardTitle = "Company Information";

    if (type == 0) {
      info = state.invoice.customerInfo;
      cardTitle = "Customer Information";
    }

    return Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(cardTitle),
            Table(
              columnWidths: {
                0: FractionColumnWidth(.26),
                1: FractionColumnWidth(.04),
                2: FractionColumnWidth(.7),
              },
              children: [
                WidgetUtil.inputLabelAsTableRpw(
                    "Name",
                    info != null && info.name != ""
                        ? Text(info.name)
                        : WidgetUtil.placeHolderTextForAddress()),
                WidgetUtil.inputLabelAsTableRpw(
                    "Address",
                    info != null && info.address != ""
                        ? Text(info.address)
                        : WidgetUtil.placeHolderTextForAddress()),
                WidgetUtil.inputLabelAsTableRpw(
                    "Country",
                    info != null && info.country != ""
                        ? Text(info.country)
                        : WidgetUtil.placeHolderTextForAddress()),
                WidgetUtil.inputLabelAsTableRpw(
                    "Phone",
                    info != null && info.phone != ""
                        ? Text(info.phone)
                        : WidgetUtil.placeHolderTextForAddress()),
                WidgetUtil.inputLabelAsTableRpw(
                    "Email",
                    info != null && info.email !=""
                        ? Text(info.email)
                        : WidgetUtil.placeHolderTextForAddress()),
              ],
            ),
          ],
        ));
  }
}
