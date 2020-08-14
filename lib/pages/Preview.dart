import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'package:invoice_generator/redux/action.dart';
import 'package:invoice_generator/redux/app_state.dart';
import 'package:invoice_generator/util/pdf_util.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

class Preview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PreviewState();
  }
}

class PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body:StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (ctx, state){
          return Container(
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  child: Text("Download PDF"),
                  onPressed: () {
                    _saveAsFile(PdfPageFormat.a4, state.invoice);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveAsFile(
    PdfPageFormat pageFormat,
    Invoice invoice
  ) async {
    PdfUtil pdfUtil = new PdfUtil();
    final Uint8List bytes = await pdfUtil.buildPdf(pageFormat,invoice);

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File file = File(appDocPath + '/' + 'document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  }
}
