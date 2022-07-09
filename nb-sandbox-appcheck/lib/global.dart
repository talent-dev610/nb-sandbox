import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sbarsmartbrainapp/pdf_api.dart';
import 'package:sbarsmartbrainapp/screens/authentication/login.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'models/patients/patient.dart';

//Todo Showcase global keys
final show2 = GlobalKey(debugLabel: '_show2'); // qr patient
final show3 = GlobalKey(debugLabel: '_show3'); // add task

SharedPreferences? prefs;

String? nurseName;

String? kUserID; // user id from firebase

// Prevent state from overwriting values on edit pt screen
int editStateCount = 0;

// Regular expression to see if string contains alphanumeric characters
// var alphaNum = RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]{1,20}$');

// Show extra features globally
bool yesDetailedLabs = false;
bool yesAdvancedAssessment = false;

// Global links
const contactLink =
    'https://nursebrain.com/contact?utm_source=nursebrain_briefcase&utm_medium=text_link&utm_campaign=in_app_cta&utm_content=contact_link';
const videoLink = 'https://www.youtube.com/channel/UCjWONIKCaVDpGBDYq4BMfgA';
// Determine if specialty has been changed
bool specialtyChanged = false;

// Current specialty of the nurse
String selectedSpecialty = "MedSurg / Tele";

Future<void> sharePDF(Patient pat) async {
  PdfApi.patients = [pat];
  final pdfFile = await PdfApi.generateCenteredText("Nurse Brain");

  if (!UniversalPlatform.isWeb) {
    PdfApi.openFile(pdfFile!);
  }
}

var editDataTask;

bool doShowCase = (prefs!.getBool('doShowCase') ?? true);
// bool doShowCase = true;
// Don't trigger showcase
noShowCase() async {
  await prefs!.setBool('doShowCase', false);
  print('doShowCase is $doShowCase');
}

// To see which url user clicks on from mobile web
bool appStoreLinks = true;

// Determine if the user is a guest
bool guest = true;
// True if guest has added a patient to their assignment
bool guestAssigned = false;
// True if logged in user has added a patient to their assignment
// bool nurseAssigned = true;
// Number of patients assigned to logged in user
int numPatients = 0;

// Global Strings
// String for when clipboard is empty
String emptyClipSection =
    guest ? 'Swipe Right to Edit!' : 'Please fill out this card!';

// login modal
showLogin(BuildContext context) async {
  final loadModal = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        print('bottom modal');
        return Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Login(),
          ),
        );
      });
  if (loadModal == 1) {
    print('global knows that login worked');
    guestAssigned = false;
    guest = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    return 1;
  }
}

String? profileId;
// current screen on bottom navy bar
int currentIndex = 0;
// int tapIndex = 1;
// index for briefcase
int initialIndex = 0;
// List<Patient> orderedPatientList = [];
List orderedPatientList = [];
void alert(String alert) {
  Fluttertoast.showToast(
    msg: alert,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.indigo,
  );
}
