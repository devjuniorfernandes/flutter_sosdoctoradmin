import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:sosdoctorsystem/constant.dart';
import 'package:sosdoctorsystem/screens/doc/justifications/pdf/utils_pdf.dart';
import 'package:sosdoctorsystem/services/doc_data_services.dart';

import '../../../../services/auth_service.dart';

class RequisitiomPdfScreen extends StatefulWidget {
  @override
  State<RequisitiomPdfScreen> createState() => _RequisitiomPdfScreenState();
}

class _RequisitiomPdfScreenState extends State<RequisitiomPdfScreen> {
  Future<Uint8List> generatePdf(
    PdfPageFormat format,
  ) async {
    String nameDoctor = await getUserName();
    int requestId = await getRequisId();
    String nomePaciente = await getRequisName();
    String agePaciente = await getRequisAge();
    String preDiaginosis = await getRequisPreD();
    String preExams = await getRequisExams();
    String data = await getRequisDate();

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
                pw.Center(
                  child: pw.Text("REQUISIÇÃO MEDICA",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('DOC REFERÊNCIA : '),
                            pw.Text('DATA DE EMISSÃO : '),
                            pw.Text('PACIENTE : '),
                            pw.Text('IDADE PACIENTE: '),
                          ]),
                      pw.SizedBox(width: 20),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "RQ000:${requestId}",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              data,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              nomePaciente,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              agePaciente,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ]),
                      pw.Spacer(),
                      pw.BarcodeWidget(
                        data:
                            "RQ000${requestId} - NOME DO PACIENTE:${nomePaciente} - DATA: $data",
                        height: 75,
                        width: 75,
                        drawText: false,
                        barcode: pw.Barcode.qrCode(),
                      ),
                    ]),
              ],
            ),
          ),
          pw.SizedBox(height: 50),
          pw.Text("Diagnostico Presuntivo:",
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Paragraph(
            margin: const pw.EdgeInsets.only(top: 10),
            text: preDiaginosis,
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.SizedBox(height: 20),
          pw.Text("Exames:",
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Paragraph(
            margin: const pw.EdgeInsets.only(top: 10),
            text: preExams,
            style: const pw.TextStyle(fontSize: 14),
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
              child: pw.Text("_____________________",
                  textAlign: pw.TextAlign.center),
            ),
            pw.Center(
              child: pw.Text(nameDoctor, textAlign: pw.TextAlign.center),
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

  Future<void> _saveAsFile(
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

  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveAsFile)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visualizador de Documento"),
        backgroundColor: kColorPrimary,
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,
        canChangePageFormat: false,
        canDebug: false,
      ),
    );
  }
}
