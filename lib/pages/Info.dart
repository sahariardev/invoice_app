import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/db/entity_manager.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/widget_utils.dart';

import 'Customer.dart';

enum SubMenu { RESET, LOAD_FROM_TEMPLATE }

class Info extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (ctx, state) {
        return Scaffold(
            appBar: AppBar(title: Text("Info"), actions: <Widget>[
              PopupMenuButton<SubMenu>(
                onSelected: (SubMenu result) {
                  if (result == SubMenu.RESET) {
                    StoreProvider.of<AppState>(ctx).dispatch(ResetInvoice());
                  } else if (result == SubMenu.LOAD_FROM_TEMPLATE) {
                    EntityManager em = new EntityManager();
                    em.getAllInvoiceTemplates().then((List<Invoice> templates) {
                      _openInvoiceListModal(ctx, state, templates);
                    }).whenComplete(() {
                      em.close();
                    });
                  }
                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<SubMenu>>[
                  const PopupMenuItem<SubMenu>(
                    value: SubMenu.RESET,
                    child: Text('Reset Invoice'),
                  ),
                  const PopupMenuItem<SubMenu>(
                    value: SubMenu.LOAD_FROM_TEMPLATE,
                    child: Text('Load From Template'),
                  ),
                ],
              )
            ]),
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
      },
    );
  }

  Widget formInfo(context, ctx, state) {
    return WidgetUtil.getCustomCard(new Column(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(_getFormIdField(ctx, state,
            state.invoice.id == null ? "" : state.invoice.id.toString())),
        WidgetUtil.formFieldsWrapper(
            _datePicker(context, "Select Date Issued", state.invoice.dateIssued,
                    (DateTime dateTime) {
                  StoreProvider.of<AppState>(context).dispatch(
                      AddDateIssued(dateTime));
                })),
        WidgetUtil.formFieldsWrapper(
            _datePicker(context, "Select Due Date", state.invoice.dateDue,
                    (DateTime dateTime) {
                  StoreProvider.of<AppState>(context).dispatch(
                      AddDateDue(dateTime));
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

  Widget _getFormIdField(context, state, initialvalue) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Form Id"),
      keyboardType: TextInputType.number,
      initialValue: initialvalue,
      autofocus: false,
      autovalidate: false,
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
        const SizedBox(height: 10),
        RaisedButton(
          onPressed: () => _showCustomDatePicker(context, initialDate, action),
          color: Colors.amber[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)),
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                pickerName,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showCustomDatePicker(BuildContext context, DateTime initialDate,
      Function action) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030));
    if (dateTime != null || dateTime != initialDate) {
      action(dateTime);
    }

    if (dateTime == null) {
      action(initialDate);
    }
  }

  Widget _getJobDescriptionForm(context, state) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Required",
          labelText: "Job Description"),
      keyboardType: TextInputType.text,
      initialValue: state.invoice.jobDescription,
      autofocus: false,
      autovalidate: false,
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

  _openInvoiceListModal(stateContext, state, List<Invoice> templates) {
    showDialog(
        context: stateContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invoice Templates'),
            content: Container(
              height: (MediaQuery
                  .of(context)
                  .size
                  .height) / 3,
              child:
              _getInvoiceTemplateListWidget(stateContext, state, templates,context),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _getInvoiceTemplateListWidget(stateContext, state,
      List<Invoice> invoiceTemplates, builderContext) {
    if (invoiceTemplates.length == 0) {
      return Text("No templates available");
    }

    return new ListView.builder(
        itemCount: invoiceTemplates.length,
        itemBuilder: (BuildContext ctx, int index) {
          Invoice invoice = invoiceTemplates[index];
          String templateName = invoice.templateName;

          return Dismissible(
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            key: Key(templateName),
            onDismissed: (direction) {
              StoreProvider.of<AppState>(ctx)
                  .dispatch(DeleteInvoiceTemplate(invoice));
            },
            child: GestureDetector(
              child: ListTile(title: Text(templateName)), onTap:(){
              StoreProvider.of<AppState>(stateContext).dispatch(LoadInvoiceFromTemplate(invoice));
              Navigator.of(builderContext).pop();
            },),
          );
        });
  }
}
