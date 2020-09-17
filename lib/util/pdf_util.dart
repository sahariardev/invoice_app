import 'package:invoice_generator/model/BillingInfo.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/model/invoice.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:invoice_generator/model/item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfUtil {
  PdfColor baseColor = PdfColor.fromHex("#33ccff");

  PdfColor accentColor = PdfColor.fromHex("#007399");

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat, Invoice invoice) async {
    final doc = pw.Document();
    final font1 = await rootBundle.load('assets/font1.ttf');
    final font2 = await rootBundle.load('assets/font2.ttf');
    final font3 = await rootBundle.load('assets/font1.ttf');
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          null,
          null,
          null,
        ),
        header: (context) => _buildHeader(context, invoice),
        footer: (context) => _buildFooter(context, invoice.id),
        build: (context) =>
        [
          _contentTable(context, invoice.items),
          _contentFooter(context, invoice)
        ],
      ),
    );
    return doc.save();
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat, pw.Font base, pw.Font bold,
      pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) =>
          pw.FullPage(
            ignoreMargins: true,
            child: pw.Stack(
              children: [
                pw.Positioned(
                  bottom: 0,
                  left: 0,
                  child: pw.Container(
                    height: 20,
                    width: pageFormat.width / 2,
                    decoration: pw.BoxDecoration(
                      gradient: pw.LinearGradient(
                        colors: [baseColor, PdfColors.white],
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  bottom: 20,
                  left: 0,
                  child: pw.Container(
                    height: 20,
                    width: pageFormat.width / 4,
                    decoration: pw.BoxDecoration(
                      gradient: pw.LinearGradient(
                        colors: [accentColor, PdfColors.white],
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: pageFormat.marginTop + 72,
                  left: 0,
                  right: 0,
                  child: pw.Container(
                    height: 3,
                    color: baseColor,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  pw.Widget _buildHeader(pw.Context context, Invoice invoice) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: 2,
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 100,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: baseColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text(invoice.id.toString()),
                          pw.Text('Date Issued'),
                          pw.Text(getFormattedDate(invoice.dateIssued)),
                          pw.Text('Date due'),
                          pw.Text(getFormattedDate(invoice.dateDue)),
                          pw.Text('Generated Date:'),
                          pw.Text(getFormattedDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    //company logo
                    child: pw.Text("Invoice Generator"),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(children: [
          pw.Expanded(
              child: pw.Column(children: [
                showInfoFromFieldValue(
                    'Company name', invoice.companyInfo.name),
                showInfoFromFieldValue(
                    'Company email', invoice.companyInfo.email),
                showInfoFromFieldValue(
                    'Company phone', invoice.companyInfo.phone),
                showInfoFromFieldValue(
                    'Company address', invoice.companyInfo.address)
              ])),
          pw.Expanded(
              child: pw.Column(children: [
                showInfoFromFieldValue(
                    'Customer name', invoice.customerInfo.name),
                showInfoFromFieldValue(
                    'Customer email', invoice.customerInfo.email),
                showInfoFromFieldValue(
                    'Customer phone', invoice.customerInfo.phone),
                showInfoFromFieldValue(
                    'Customer address', invoice.customerInfo.address)
              ]))
        ]),
        pw.SizedBox(height: 10),
        if (context.pageNumber > 1) pw.SizedBox(height: 10)
      ],
    );
  }

  getFormattedDate(DateTime date) {
    return new DateFormat('yyyy-MM-dd').format(date);
  }

  showInfoFromFieldValue(String label, String value) {
    return pw.Row(children: [
      pw.Expanded(child: pw.Text(label + " : ")),
      pw.Expanded(child: pw.Text(value))
    ]);
  }

  pw.Widget _buildFooter(pw.Context context, int id) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice# $id',
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey,
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context, List<Item> items) {
    const tableHeaders = [
      'SKU#',
      'Item Description',
      'Price',
      'Quantity',
      'Total'
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColor.fromHex('#575757'),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.blueGrey800,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
            (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        items.length,
            (row) =>
        List<String>.generate(
          tableHeaders.length,
              (col) => items[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context, Invoice invoice) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 10),
              pw.Text(
                'Thank you for your business',
                style: pw.TextStyle(
                  color: accentColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.black,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 5),
                //add tax here
                //pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(invoice.getTotal().toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
