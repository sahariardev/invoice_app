import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/pdf_util.dart';
import 'package:invoice_generator/util/widget_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:invoice_generator/util/constants.dart';

class Preview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PreviewState();
  }
}

class PreviewState extends State<Preview> {
  final _formKey = GlobalKey<FormState>();

  String templateName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SUMMARY),
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (ctx, state) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Column(children: [getSummery(state)]),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Center(
                        child: WidgetUtil.getCustomButton(DOWNLOAD_INVOICE,
                            () => _saveAsFile(PdfPageFormat.a4, state))),
                    SizedBox(height: 10),
                    WidgetUtil.getCustomButton(SAVE_TEMPLATE,
                        () => _openTemplateNameDialog(ctx, state)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _saveAsFile(PdfPageFormat pageFormat, AppState state) async {
    PdfUtil pdfUtil = new PdfUtil();
    final Uint8List bytes = await pdfUtil.buildPdf(pageFormat, state);

    if (await Permission.storage.request().isGranted) {
      final Directory appDocDir =
          await DownloadsPathProvider.downloadsDirectory;
      final String appDocPath = appDocDir.path;
      print(appDocPath);
      final File file =
          File(appDocPath + '/' + DateTime.now().toString() + '-invoice.pdf');
      print('Save as file ${file.path} ...');
      await file.writeAsBytes(bytes);
      OpenFile.open(file.path);
    }
  }

  _openTemplateNameDialog(stateContext, state) {
    showDialog(
        context: stateContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(TEMPLATE_NAME),
            content: Form(
              key: _formKey,
              child: Container(
                height: (MediaQuery.of(context).size.height) / 3,
                child: _getModalFormFields(stateContext, state),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(BUTTON_CANCEL),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(BUTTON_SUBMIT),
                onPressed: () {
                  //validate
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pop();
                    StoreProvider.of<AppState>(stateContext).dispatch(
                        SaveInvoiceTemplate(state.invoice, templateName));
                  }
                },
              )
            ],
          );
        });
  }

  _getModalFormFields(stateContext, state) {
    return ListView(
      children: <Widget>[
        WidgetUtil.formFieldsWrapper(getName(templateName, (val) {
          templateName = val;
        })),
      ],
    );
  }

  Widget getName(String initialValue, Function function) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          helperText: REQUIRED,
          labelText: NAME),
      autofocus: false,
      autovalidateMode: AutovalidateMode.disabled,
      initialValue: initialValue,
      onSaved: (val) {
        function(val);
      },
      validator: (String val) {
        if (val.length < 3) {
          return VALIDATION_NAME;
        }
        return null;
      },
    );
  }

  Widget getSummery(state) {
    if (state == null || state.invoice == null) {
      return new Container();
    }
    return WidgetUtil.getCustomCard(
      Column(
        children: <Widget>[
          Table(
            columnWidths: {
              0: FractionColumnWidth(.36),
              1: FractionColumnWidth(.04),
              2: FractionColumnWidth(.6),
            },
            children: [
              WidgetUtil.inputLabelAsTableRpw(
                  FORM_ID, Text(state.invoice.id.toString())),
              WidgetUtil.inputLabelAsTableRpw(
                  CUSTOMER_NAME,
                  Text(state.invoice.customerInfo == null
                      ? ""
                      : state.invoice.customerInfo.getNameWithEmail())),
              WidgetUtil.inputLabelAsTableRpw(
                  COMPANY_NAME,
                  Text(state.invoice.companyInfo == null
                      ? ""
                      : state.invoice.companyInfo.getNameWithEmail())),
              WidgetUtil.inputLabelAsTableRpw(TOTAL_ITEM,
                  Text(state.invoice.getTotalItems().toString())),
              WidgetUtil.inputLabelAsTableRpw(TOTAL_PRICE,
                  Text(state.invoice.getTotal().toString() + " TK")),
              WidgetUtil.inputLabelAsTableRpw(
                  DUE_DATE,
                  Text(new DateFormat('yyyy-MM-dd')
                      .format(state.invoice.dateDue)
                      .toString())),
              WidgetUtil.inputLabelAsTableRpw(
                  VAT, Text(state.vat.toString())),
              WidgetUtil.inputLabelAsTableRpw(
                  SERVICE_CHARGE, Text(state.serviceCharge.toString())),
              WidgetUtil.inputLabelAsTableRpw(
                  DELIVERY_CHARGE, Text(state.deliveryCharge.toString()))
            ],
          ),
        ],
      ),
    );
  }
}
