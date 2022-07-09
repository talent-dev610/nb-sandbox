import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/global.dart';
import 'package:sbarsmartbrainapp/models/patients/patient.dart';
import 'package:sbarsmartbrainapp/services/backend.dart';
// import 'package:sbarsmartbrainapp/models/patients/add_pt.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:sbarsmartbrainapp/supps/sbar_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../global.dart';
import '../../clip_board.dart';

class AddPatientForm extends StatefulWidget {
  final String selectedSpecialty;
  // final AddPatient addPt = AddPatient();

  AddPatientForm({required this.selectedSpecialty});

  @override
  AddPatientFormState createState() => AddPatientFormState();
}

class AddPatientFormState extends State<AddPatientForm> {
  void shareOrderedPatient(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("OrderedPatient", str);
  }

  // Guest patient
  late Patient pat;
  // Main Patient Form
  final _patientFormKey =
      GlobalKey<FormState>(debugLabel: 'pt form global key');
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'pt form scaffold key');

  @override
  Widget build(BuildContext context) {
    // Add specialty to object
    // widget.addPt.specialty = widget.selectedSpecialty;
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Form(
            key: _patientFormKey,
            child: Column(
              children: <Widget>[
                // Situation Card
                ExpandableNotifier(
                  child: SbarCard(
                    label: 'Situation',
                    labelBgColor: kLavenSky,
                    cardShadowColor: kDarkSky,
                    cardChild: doShowCase && guest
                        ? Showcase(
                            key: show2,
                            title: 'Enter patient details',
                            description:
                                'Enter your patient\'s details using the SBAR method',
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 768) {
                                  return Text('Patient Situation');
                                } else {
                                  return Text('Patient Situation (responsive)');
                                }
                              },
                            ),
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 768) {
                                return Text('Patient Situation');
                              } else {
                                return Text('Patient Situation (responsive)');
                              }
                            },
                          ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // Background Card
                ExpandableNotifier(
                  child: SbarCard(
                    label: 'Background',
                    labelBgColor: kDawnSky,
                    cardShadowColor: kDarkSky,
                    cardChild: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 768) {
                          return Text('Patient Background');
                        } else {
                          return Text('Patient Background (responsive)');
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                // Assessment Card
                ExpandableNotifier(
                  child: SbarCard(
                    label: 'Assessment',
                    labelBgColor: kOceanSky,
                    cardShadowColor: kDarkSky,
                    cardChild: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 768) {
                          return Text('Patient Assessment');
                        } else {
                          return Text('Patient Assessment (responsive)');
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                // Recommendation Card
                ExpandableNotifier(
                  child: SbarCard(
                    label: 'Recommendation',
                    labelBgColor: kAlgaeSea,
                    cardShadowColor: kDarkSky,
                    cardChild: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 768) {
                          return Text('Patient Recommendation');
                        } else {
                          return Text('Patient Recommendation (responsive)');
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                // Events Card
                ExpandableNotifier(
                  child: SbarCard(
                    label: 'Significant Events',
                    labelBgColor: Colors.yellow[800],
                    cardShadowColor: kDarkSky,
                    cardChild: Text('Significant Events'),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _submitForm();
          if (_patientFormKey.currentState!.validate() && guest) {
            // print pdf for guests upon save
            sharePDF(pat);
          }
        },
        label: doShowCase && guest
            ? Showcase(
                key: show3,
                title: UniversalPlatform.isWeb
                    ? 'Handoff Report'
                    : 'Save your patient',
                description: UniversalPlatform.isWeb
                    ? 'View PDF printout to use or share with the next nurse!'
                    : 'Save, edit and share with others as needed!',
                child: Text('Handoff'))
            : Text(guest
                ? UniversalPlatform.isWeb
                    ? 'Handoff'
                    : 'Save'
                : 'Save'),
        backgroundColor: kJadeLake,
        icon: Icon(guest
            ? !UniversalPlatform.isWeb
                ? FontAwesomeIcons.save
                : FontAwesomeIcons.fileExport
            : FontAwesomeIcons.save),
      ),
    );
  }

  _submitForm() async {
    noShowCase();
    if (_patientFormKey.currentState!.validate()) {
      await _savePtToDb(); // saving object to DB
// await widget.addPt.savePtToDb(); // saving object to DB
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Clipboard(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: kMediumSnack,
          backgroundColor: kMidNightSkyBlend,
          content: Text(
            'Please fill in all required fields!',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }
  }

  _savePtToDb() async {
    pat = Patient(
      nicknameField: 'Test Patient',
    );
    // save patient locally
    if (guest) {
      SharedPreferences _prefs;
      _prefs = await SharedPreferences.getInstance();
      Map<String?, dynamic> localPat = pat.toMap();
      bool result =
          await _prefs.setString('guestPatient', jsonEncode(localPat));
      return result;
    } else {
      // save patient to database
      await Backend().addPatient(pat);
    }
    // reset bool
    specialtyChanged = false;
  }
}
