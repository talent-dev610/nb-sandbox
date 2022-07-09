import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
// import 'package:sbarsmartbrainapp/models/patients/edit_pt.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_platform/universal_platform.dart';

import 'models/patients/patient.dart';

const kStackBodyStylePdf = TextStyle(
  fontSize: 10.0,
);
final kStackBodyStyleBold = TextStyle(
  fontSize: 10.0,
  fontWeight: FontWeight.bold,
);

class PdfApi {
  static late List<Patient> patients;

  static Future<File?> generateCenteredText(String text) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) {
          List<Widget> clipList = [];
          // Loop to generate PDF Clipboard
          for (var i = 0; i < patients.length; i++) {
            print(patients[i].id);
            clipList.add(buildList(i));
            print(i);
            print(clipList.length);
          }
          return clipList;
        },
        footer: (context) {
          return buildFooter(context);
        },
      ),
    );
    return saveDocument(name: 'NurseBrain.pdf', pdf: pdf);
  }

  // Methods
  static Widget buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 25,
                width: 25,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: 'https://nursebrain.app',
                ),
              ),
            ],
          ),
        ],
      );

  static Widget buildList(int position) {
    Patient patient = patients[position];
    print('In build list - ${patient.id}');
    // EditPatient editPt = EditPatient(patientObject: patient);
    return Text('Patient Assignment');
  }

  static Widget buildFooter(context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: TextStyle(color: PdfColors.black),
            ),
            Text(
              'nursebrain.app',
              style: TextStyle(color: PdfColors.black),
            ),
            SizedBox(height: 8.0),
          ]),
          SizedBox(width: 8.0),
          Container(
            height: 30,
            width: 30,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data:
                  'https://nursebrain.app/?utm_source=pdf_qr_scan&utm_medium=handoff_pdf_printout&utm_campaign=organic_bedside',
            ),
          ),
        ],
      ),
    );
  }

  // Filing Methods
  static Future<File?> saveDocument({
    String? name,
    Document? pdf,
  }) async {
    if (UniversalPlatform.isWeb) {
      await downloadPDF(pdf!, name: name);
      return null;
    } else {
      final bytes = await pdf!.save();

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');

      await file.writeAsBytes(bytes);

      return file;
    }
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<void> downloadPDF(Document pdf,
      {String? name = "SBAR_patient.pdf"}) async {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');

    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = name;
    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
