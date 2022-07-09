import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/models/patients/patient.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:sbarsmartbrainapp/screens/patients/edit/edit_patient_form.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

import '../../../global.dart';

class SbarEdit extends StatefulWidget {
  final Patient? patient;
  SbarEdit({required this.patient});

  @override
  _SbarEditState createState() => _SbarEditState();
}

class _SbarEditState extends State<SbarEdit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // }
      },
      child: Builder(
        builder: (context) {
          // theme for form fields
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kDarkSky,
                    kNightSky,
                    kNoonSky,
                    kOceanSky,
                  ],
                  stops: [0.1, 0.5, 0.8, 1.0],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    // Close Screen
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Just Checking...'),
                            content: Text(
                                'Are you sure you want to close without saving your changes?'),
                            actions: [
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  currentIndex = 1;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text('Keep Open'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          barrierDismissible: true,
                        );
                      },
                      onDoubleTap: () {
                        currentIndex = 1;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.circleChevronDown,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        // patientHeader ??
                        Row(
                          children: [
                            Text(
                              "Update ",
                              style: kFormHeaderStyle,
                            ),
                            Text(
                              "Patient",
                              style: kFormHeaderStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                body: EditPatientForm(
                    // patientObject: widget.patient,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
