import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'services/firebase_analytics.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/patients/patient.dart';
import 'pdf_api.dart';

class QRShare {
  static final _share = QRShare._internal();
  factory QRShare() => _share;
  QRShare._internal();

  final delimiter = "/";

  List<Patient>? patients;

  BehaviorSubject<int>? _dialogController;
  Function get addDialog => _dialogController!.sink.add;
  Stream<int> get getDialog => _dialogController!.stream;

  BehaviorSubject<List<bool?>>? _selectionController;
  void select(int index, bool? value) {
    List<bool?> _ = _selectionController!.value;
    _[index] = value;
    _selectionController!.sink.add(_);
  }

  void selectAll() {
    _selectionController!.sink
        .add(List.generate(patients!.length, (index) => true));
  }

  void unSelectAll() {
    _selectionController!.sink
        .add(List.generate(patients!.length, (index) => false));
  }

  Stream<List<bool?>> get getSelected => _selectionController!.stream;

  bool? isQRVisible;

  void init(List<Patient> patients, {int? index}) {
    this.patients = patients;
    _dialogController = BehaviorSubject();
    addDialog(0);
    _selectionController = BehaviorSubject();
    List<bool?> initialData = List.generate(patients.length, (index) => false);
    if (index != null) initialData[index] = true;
    _selectionController!.sink.add(initialData);

    isQRVisible = false;
  }

  String getQRData() {
    String qr = FirebaseAuth.instance.currentUser!.uid;
    for (Patient patient in getSelectedPatients())
      qr += "$delimiter${patient.id}";
    return qr;
  }

  // This method runs on user B's side and request for access of patient with id as 'patientID'
  Future<void> receiveAccess(String qrData) async {
    print('QRData: $qrData');
    if (qrData.startsWith('https://')) {
      print("1");
      if (await canLaunch(qrData)) launch(qrData);
      print("2");
    } else {
      print("3");
      List<String> split = qrData.split(delimiter);
      print("4");
      if (split.length > 1) {
        print("5");
        String uid = split[0];
        print("6");
        List<String> patientIDs = split.sublist(1);
        print("7");
        await copyPatients(uid, patientIDs);
        print("8");
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({'is_sharing': true}, SetOptions(merge: true));
        print("9");
      }
    }
    print("10");
  }

  Future<void> copyPatients(String uid, List<String> patients) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (String patientID in patients) {
      print("Copying patient with ID: $patientID");
      Map<String, dynamic> patientMap = (await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('patients')
              .doc(patientID)
              .get())
          .data()!;

      DocumentReference doc = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('patients')
          .doc();

      patientMap['id'] = doc.id;
      batch.set(doc, patientMap, SetOptions(merge: true));
      print('Set patient');
    }
    await batch.commit();
    print('Committed to db!');
  }

  List<Patient> getSelectedPatients() {
    List<Patient> selectedPatients = [];
    for (int i = 0; i < _selectionController!.value.length; ++i)
      if (_selectionController!.value[i]!) selectedPatients.add(patients![i]);
    return selectedPatients;
  }

  Future<void> sharePDF() async {
    PdfApi.patients = getSelectedPatients();
    final pdfFile = await PdfApi.generateCenteredText("Nurse Brain");

    if (!UniversalPlatform.isWeb) {
      PdfApi.openFile(pdfFile!);
    }
  }

  Future<void> dispose() async {
    if (_selectionController != null) {
      await _selectionController!.sink.close();
      await _selectionController!.close();
    }

    if (_dialogController != null) {
      await _dialogController!.sink.close();
      await _dialogController!.close();
    }
  }
}
