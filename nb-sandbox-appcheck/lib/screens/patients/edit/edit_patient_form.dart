import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sbarsmartbrainapp/models/patients/edit_pt.dart';
// import 'package:sbarsmartbrainapp/models/patients/patient.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:sbarsmartbrainapp/supps/sbar_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPatientForm extends StatefulWidget {
  // final Patient patient;

  // EditPatientForm({Patient patientObject}) : patient = patientObject;

  @override
  EditPatientFormState createState() => EditPatientFormState();
}

class EditPatientFormState extends State<EditPatientForm> {
  // Main Patient Form
  final _patientFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void shareOrderedPatient(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("OrderedPatient", str);
  }

  @override
  Widget build(BuildContext context) {
    // Class containing variables for editing patient
    /*EditPatient editPt = EditPatient(
      patientObject: widget.patient,
    );*/
    // Initialize values of edit patient variables (from EditPatient)
    // using the patient object from DB

    // editPt.setValues();

    // Save form to DB
    _submitForm() async {
      if (_patientFormKey.currentState!.validate()) {
        // await editPt.savePtToDb(); // saving object to DB
        Navigator.pop(context);
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
                    cardChild: LayoutBuilder(
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
                  height: 16.0,
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
        },
        label: Text('Save'),
        backgroundColor: kJadeLake,
        icon: Icon(FontAwesomeIcons.save),
      ),
    );
  }
}
