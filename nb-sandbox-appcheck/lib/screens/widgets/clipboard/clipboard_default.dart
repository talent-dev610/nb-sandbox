import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/global.dart';
// import 'package:sbarsmartbrainapp/models/patients/edit_pt.dart';
import 'package:sbarsmartbrainapp/models/patients/patient.dart';
import 'package:sbarsmartbrainapp/screens/tasks/add_task.dart';
// import 'package:sbarsmartbrainapp/screens/widgets/clipboard/sbar_sections/default/clipboard_assessment.dart';
// import 'package:sbarsmartbrainapp/screens/widgets/clipboard/sbar_sections/default/clipboard_background.dart';
// import 'package:sbarsmartbrainapp/screens/widgets/clipboard/sbar_sections/default/clipboard_situation.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:sbarsmartbrainapp/supps/sbar_card.dart';

import '../../clip_board.dart';

class ClipboardDefault extends StatelessWidget {
  final Patient patient;

  ClipboardDefault({required Patient patientObject}) : patient = patientObject;

  @override
  Widget build(BuildContext context) {
    // EditPatient editPt = EditPatient(patientObject: patient);
    Widget expandedSituation() {
      return Column(
        children: [
          // Situation card
          Text('Patient Situation'),
          SizedBox(
            height: 10.0,
          ),
          // Background card
          Text('Patient Background'),
          SizedBox(
            height: 10.0,
          ),
          // Assessment Category
          Text('Patient Assessment'),
          SizedBox(
            height: 10.0,
          ),
          // Recommendation card
          SbarCard(
            label: 'Recommendation',
            labelBgColor: kAlgaeSea,
            cardShadowColor: kMidNightSkyBlend,
            cardChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Visibility(
                    visible: (patient.consultDrop.toString().length <= 4 &&
                        patient.consultCommentField == '' &&
                        patient.stickyNoteRecommendationField == ''),
                    child: Text('Please fill out this card!'),
                  ),
                  Visibility(
                    visible: patient.consultDrop.toString().length > 4,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Consults: ',
                          style: kStackHeaderStyle,
                        ),
                        Text(
                          '${patient.consultDrop != null ? patient.consultDrop : 'None specified'}',
                          style: kStackBodyStyle,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: patient.consultCommentField != '' &&
                        patient.consultCommentField != null,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Consult Comment: ',
                          style: kStackHeaderStyle,
                        ),
                        Text(
                          '${patient.consultCommentField != null ? patient.consultCommentField : 'None specified'}',
                          style: kStackCommentStyle,
                        ),
                      ],
                    ),
                  ),
                  // Show toodo list
                  Visibility(
                    visible: patient.stickyNoteRecommendationField != '' &&
                        patient.stickyNoteRecommendationField != null,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Recommendation Notes: ',
                          style: kStackHeaderStyle,
                        ),
                        Text(
                          '${patient.stickyNoteRecommendationField != null ? patient.stickyNoteRecommendationField : 'None specified'}',
                          style: kStackCommentStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Events card
          SbarCard(
            label: 'Significant Events',
            labelBgColor: Colors.yellow[800],
            cardShadowColor: kMidNightSkyBlend,
            cardChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Visibility(
                    visible: (patient.stickySigEventField == ''),
                    child: Text('No significant events to display.'),
                  ),
                  Visibility(
                    visible: patient.stickySigEventField != '' &&
                        patient.stickySigEventField != null,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Significant Events: ',
                          style: kStackHeaderStyle,
                        ),
                        Text(
                          '${patient.stickySigEventField != null ? patient.stickySigEventField : 'None specified'}',
                          style: kStackCommentStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Mar / TodoList
          GestureDetector(
            onDoubleTap: () {
              if (guest) {
                showLogin(context);
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AddTask(pt: patient)));
              }
            },
            child: SbarCard(
              label: 'MAR / Todo List',
              labelBgColor: kJadeLake,
              cardShadowColor: kMidNightSkyBlend,
              cardChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: showTodo(patient),
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      );
    }

    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            tapBodyToExpand: guest ? false : true,
            tapBodyToCollapse: true,
            tapHeaderToExpand: true,
          ),
          collapsed: guest
              ? expandedSituation()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Situation card
                    Text('Patient Situation'),
                    SizedBox(
                      height: 10.0,
                    ),
                    // MAR TodoList
                    GestureDetector(
                      onDoubleTap: () {
                        if (guest) {
                          showLogin(context);
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AddTask(pt: patient)));
                        }
                      },
                      child: SbarCard(
                        label: 'MAR / Todo List',
                        labelBgColor: kJadeLake,
                        cardShadowColor: kMidNightSkyBlend,
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: showTodo(patient),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
          expanded: expandedSituation(),
        ),
      ),
    );
  }
}
