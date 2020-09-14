import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/pdf_util.dart';
import 'package:invoice_generator/util/widget_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

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
        title: Text("Preview"),
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (ctx, state) {
          return Container(
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  child: Text("Download PDF"),
                  onPressed: () {
                    _saveAsFile(PdfPageFormat.a4, state.invoice);
                  },
                ),
                RaisedButton(
                  child: Text("Save As Template"),
                  onPressed: () {
                    _openTemplateNameDialog(ctx, state);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveAsFile(PdfPageFormat pageFormat, Invoice invoice) async {
    PdfUtil pdfUtil = new PdfUtil();
    final Uint8List bytes = await pdfUtil.buildPdf(pageFormat, invoice);

    if (await Permission.storage.request().isGranted) {
      final Directory appDocDir = await DownloadsPathProvider.downloadsDirectory;
      final String appDocPath = appDocDir.path;
      print(appDocPath);
      final File file = File(appDocPath + '/' +DateTime.now().toString()+ '-invoice.pdf');
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
            title: const Text('Template Name'),
            content: Form(
              key: _formKey,
              child: Container(
                height: (MediaQuery.of(context).size.height) / 3,
                child: _getModalFormFields(stateContext, state),
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
}
