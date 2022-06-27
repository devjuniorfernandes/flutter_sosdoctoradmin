import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

_generatePdf(
  PdfPageFormat format,
) async {
  final doc = pw.Document(title: "Flutter School");
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
  );
  final footerImage = pw.MemoryImage(
    (await rootBundle.load('assets/footer.png')).buffer.asUint8List(),
  );
  final assImage = pw.MemoryImage(
    (await rootBundle.load('assets/doc_ass.png')).buffer.asUint8List(),
  );
  final font = await rootBundle.load('assets/RobotoRegular.ttf');
  final ttf = pw.Font.ttf(font);

  final _pageTheme = await myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: _pageTheme,
      header: (final context) => pw.Image(
        alignment: pw.Alignment.topLeft,
        logoImage,
        width: 150,
        height: 100,
        fit: pw.BoxFit.contain,
      ),
      footer: (final context) => pw.Image(
        footerImage,
        fit: pw.BoxFit.scaleDown,
      ),
      build: (final context) => [
        pw.Container(
          padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Paciente : '),
                          pw.Text('Assunto : '),
                          pw.Text('Data : '),
                        ]),
                    pw.SizedBox(width: 20),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Nome do Paciente',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            'Assunto do Paciente',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            '20-06-2022',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ]),
                    pw.Spacer(),
                    pw.BarcodeWidget(
                      data: "Ladislau Augusto",
                      height: 75,
                      width: 75,
                      drawText: false,
                      barcode: pw.Barcode.qrCode(),
                    ),
                  ]),
            ],
          ),
        ),
        pw.Center(
          child: pw.Text("Lorem Ipsom Dolor"),
        ),
        pw.Paragraph(
          margin: const pw.EdgeInsets.only(top: 10),
          text: bodyText,
        ),
        pw.SizedBox(height: 20),
        pw.Paragraph(
          margin: const pw.EdgeInsets.only(top: 10),
          text: bodyText,
        ),
        pw.SizedBox(height: 20),
        pw.Column(children: [
          pw.Center(
            child: pw.Image(
              alignment: pw.Alignment.center,
              assImage,
              width: 200,
              height: 75,
              fit: pw.BoxFit.contain,
            ),
          ),
          pw.Center(
            child: pw.Text("_____________________", textAlign: pw.TextAlign.center),
          ),
          pw.Center(
            child: pw.Text("Lorem Ipsom Dolor", textAlign: pw.TextAlign.center),
          ),
        ])
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> myPageTheme(PdfPageFormat format) async {
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
  );

  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 1 * PdfPageFormat.cm,
      vertical: 0.5 * PdfPageFormat.cm,
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) => pw.FullPage(
      ignoreMargins: false,
      child: pw.Watermark(
        angle: 0,
        child: pw.Opacity(
          opacity: 0.1,
          child: pw.SizedBox(
            width: 400,
            height: 400,
            child: pw.Image(
              alignment: pw.Alignment.center,
              logoImage,
              fit: pw.BoxFit.contain,
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print('save as File ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Docmunt printed successfully!")));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Docmunt shared successfully!")));
}

const String bodyText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
    "Praesent et ligula ante. Curabitur interdum venenatis euismod. "
    "Sed ultrices varius eros non semper. Integer sodales mattis dolor, "
    "nec cursus est tincidunt a. Praesent quis diam ornare sapien consequat "
    "varius quis nec ante. Quisque viverra, est sed dapibus tempus, nisl dui"
    "mollis purus, at lacinia dolor orci sit amet est. Etiam in ex non "
    "magna pellentesque feugiat. Etiam ac ante nec libero iaculis egestas ut "
    "et tellus. Quisque dapibus et dolor vitae semper. Vivamus vitae ante interdum,"
    "posuere arcu vel, tempor velit. Maecenas in ipsum nisi. Aliquam at ante "
    "sit amet est sollicitudin faucibus. Sed ultrices dolor vel orci scelerisque"
    "gravida. Praesent suscipit malesuada orci, sit amet porta ligula. In hac"
    "habitasse platea dictumst. Pellentesque ultrices dolor et velit finibus lobortis. ";
