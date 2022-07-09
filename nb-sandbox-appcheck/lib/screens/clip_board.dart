import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/extra/scan.dart';
import 'package:sbarsmartbrainapp/extra/share_dialog.dart';
import 'package:sbarsmartbrainapp/models/todo.dart';
import 'package:sbarsmartbrainapp/qr_share.dart';
import 'package:sbarsmartbrainapp/screens/patients/edit/edit_pt_frame.dart';
import 'package:sbarsmartbrainapp/screens/widgets/clipboard/clipboard_default.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:universal_platform/universal_platform.dart';

import '../global.dart';
import '../models/patients/patient.dart';
import '../services/backend.dart';
import '../supps/sbar_card.dart';
import 'patients/add/add_pt_frame.dart';
import 'tasks/add_task.dart';

class Clipboard extends StatefulWidget {
  @override
  ClipboardState createState() => ClipboardState();
}

class ClipboardState extends State<Clipboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String>? ptTasksList;
  var pat;

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenClipboard();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // Screen Guide
          if (numPatients > 0)
            IconButton(
              icon: Tooltip(
                message: 'How to use the clipboard',
                child: Icon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              onPressed: () {
                _screenGuide();
              },
            )
        ],
        title: _userAppBar(),
        elevation: 0.0,
        backgroundColor: kDarkSky,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Backend().patientStream1,
          builder: (context, snapshot) {
            guest = false;
            guestAssigned = false;
            int length = snapshot.hasData ? snapshot.data!.size : 0;
            numPatients = length;
            if (length == 0) {
              // Show All caught up card
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        child: Card(
                          // color: Colors.orangeAccent[100],
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidCheckCircle,
                                color: kRichGrass,
                              ),
                              onPressed: () {},
                            ),
                            title: Text(
                              'All caught up!',
                              style: kCaughtUpStyle,
                            ),
                            subtitle: Text(
                              'Tap here to add a patient to your clipboard using the SBAR method',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: _goToAddPatient,
                        onDoubleTap: () async {
                          if (!UniversalPlatform.isWeb) {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => QRScan(),
                              ),
                            );
                          } else {}
                        },
                      ),
                    ),
                  )
                ],
              );
            }
            List<Patient> patients = snapshot.data!.docs
                .map((e) => Patient.fromMap(e.data() as Map<String, dynamic>))
                .toList();
            if (orderedPatientList.length != 0) {
              if (patients.length != orderedPatientList.length) {
                orderedPatientList = patients;
              }
              patients = orderedPatientList as List<Patient>;
            }
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
                shadowColor: Colors.yellowAccent,
              ),
              child: ReorderableListView.builder(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 6.0, right: 6.0, bottom: 8.0),
                shrinkWrap: true,
                itemCount: snapshot.hasData ? patients.length : 0,
                onReorder: (oldIndex, newIndex) {
                  newIndex = newIndex;
                  if (newIndex > oldIndex) {
                    newIndex = newIndex - 1;
                  }
                  final patientCard = patients.removeAt(oldIndex);
                  patients.insert(newIndex, patientCard);
                  orderedPatientList = patients;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  final String? key = patients[index].id;
                  return GestureDetector(
                    key: ValueKey(key),
                    onDoubleTap: () {
                      pat = patient;
                      _goToEditPatient();
                      setState(() {});
                    },
                    child: Column(
                      children: <Widget>[
                        Slidable(
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: kOceanSky,
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.fileExport,
                                onPressed: (context) async {
                                  List<Patient> patients =
                                      await Backend().getPatients();
                                  QRShare().init(patients, index: index);
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .snapshots()
                                      .listen((event) async {
                                    Map<String, dynamic> data = event.data()!;
                                    if (data['is_sharing'] &&
                                        QRShare().isQRVisible!) {
                                      Navigator.of(context).pop();
                                      QRShare().isQRVisible = false;
                                      await event.reference.set(
                                          {'is_sharing': false},
                                          SetOptions(merge: true));
                                    } else if (data['is_sharing']) {
                                      await event.reference.set(
                                          {'is_sharing': false},
                                          SetOptions(merge: true));
                                    }
                                  });
                                  await showDialog(
                                    context: context,
                                    builder: (context) => ShareDialog(patients),
                                  );
                                },
                              ),
                              SlidableAction(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.solidPenToSquare,
                                onPressed: (context) {
                                  //tag correct patient with unique id
                                  // patient.id = index;
                                  pat = patient;
                                  _goToEditPatient();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.red[700]!,
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.trash,
                                onPressed: (context) async {
                                  await Backend()
                                      .deletePatient(patients[index]);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          child: SbarStack(
                            cardShadowColor: kMidNightSkyBlend,
                            label: patient.nicknameField != null
                                ? ('Patient: ${patient.nicknameField.toString().toUpperCase()}, ${patient.ageField} ${patient.genderRadio.toString()}, Room ${patient.roomNumberField.toString().toUpperCase()}, ${patient.codeStatusDrop != null ? patient.codeStatusDrop : 'Check Code!'}')
                                : 'My Patient',
                            labelBgColor: Colors.grey[300],
                            cardChild: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) {
                                    if (constraints.maxWidth < 768)
                                      return ClipboardDefault(
                                        patientObject: patient,
                                      );
                                    else
                                      return Text('Clipboard Responsive');
                                  }),
                                ],
                              ),
                            ),
                            footerChild: Container(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
      floatingActionButton: guest
          ? Container()
          : UniversalPlatform.isWeb
              ? FloatingActionButton(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    FontAwesomeIcons.plus,
                  ),
                  onPressed: () {
                    _goToAddPatient();
                  },
                )
              : SpeedDial(
                  overlayOpacity: 0.0,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: FontAwesomeIcons.plus,
                  children: [
                      SpeedDialChild(
                        backgroundColor: kDawnSky,
                        foregroundColor: Colors.white,
                        child: Icon(FontAwesomeIcons.procedures),
                        onTap: () {
                          _goToAddPatient();
                        },
                      ),
                      SpeedDialChild(
                        backgroundColor: kDarkSky,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.qr_code_scanner),
                        onTap: () async {
                          {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => QRScan(),
                              ),
                            );
                          }
                        },
                      )
                    ]),
    );
  }

  Widget _userAppBar() {
    if (numPatients > 0)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            numPatients == 1
                ? ('1 Patient Assigned')
                : ('$numPatients Patients Assigned'),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    else
      return Container();
  }

  _screenGuide() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Screen Guide'),
        content: Container(
          height: 250,
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patient Handoff',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.fileExport),
                    SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Swipe right on the patient to create a printer-friendly handout to share with the next nurse'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'Patient Card',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Tap once to expand and view more details'),
                Text('Double tap to edit patient'),
                Text('Tap and hold to rearrange patient order'),
                Text('Swipe right to delete patient'),
                Text('Double tap MAR/Todo List to add new task'),
                SizedBox(height: 12.0),
                Text(
                  'Action Button (+)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Tap once to add or import a patient via a QR code'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  _goToAddPatient() async {
    print('guest assigned: $guestAssigned');
    if (guest && guestAssigned) {
      final uploadPt = await showLogin(context);
      if (uploadPt == 1) {
        print('add patient fn recognized login');
      } else {
        print('clipboard NOT updated');
      }
    } else {
      final addPt = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SbarAdd(),
        ),
      );
      if (addPt == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: kMediumSnack,
            backgroundColor: kMidNightSkyBlend,
            content: Text(
              'Patient added!',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        );
        // });
      } else {}
    }
  }

  _goToEditPatient() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SbarEdit(
          patient: pat,
        ),
      ),
    );
    if (result == 1) {
      // setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: kMediumSnack,
          backgroundColor: kMidNightSkyBlend,
          content: Text(
            'Patient edited!',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      );
      // });
    } else {
      // setState(() {});
    }
  }
}

// Display Custom TodoList widget function on clipboard
Widget showTodo(patient) {
  List? todoClass;
  return StreamBuilder<QuerySnapshot>(
      stream: Backend().taskStream1,
      builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return TextButton(
                  child: Text('Add Task/Med'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: kJadeLake,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddTask(pt: patient),
                      ),
                    );
                  },
                );
        }
        todoClass = snapshot.data!.docs
            .map((e) => TodoClass.fromMap(e.data() as Map<String, dynamic>))
            .toList();

        // try sorting
        try {
          todoClass!.sort((a, b) => a.exactDue.compareTo(b.exactDue));
        } catch (e) {
          print('sorting error: $e');
        }

        List ptTasks = [];
          for (int i = 0; i < todoClass!.length; i++) {
          // tasks for each patient
          final taskObject = todoClass![i];
          if (taskObject.todoPt.contains(patient.roomNumberField)) {
            ptTasks.add(taskObject.todoTitle);
          }
        }
        return
            // Container();
            Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                  itemCount: todoClass!.length,
                itemBuilder: (context, index) {
                  final tasks = todoClass![index];
                  if (tasks.todoPt == patient.roomNumberField) {}

                  String bullet = '\u2022';

                  return Visibility(
                    visible: tasks.todoPt == patient.roomNumberField,
                    child: Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '$bullet ${tasks.todoTitle}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' (${tasks.todoCat})',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: tasks.todoCat == 'Medication'
                                          ? Colors.green[800]
                                          : Colors.blue[700])),
                              TextSpan(
                                  text: tasks.todoDesc.isNotEmpty ? ': ' : '',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: tasks.todoDesc),
                              TextSpan(text: ' (due @ ${tasks.todoStart})'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            // Add Task
            if (ptTasks.isEmpty)
              TextButton(
                child: Text('Add Task/Med'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: kJadeLake,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  if (guest) {
                    showLogin(context);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddTask(pt: patient),
                      ),
                    );
                  }
                },
              ),
            /*if (ptTasks.isNotEmpty)
              Text(
                '(double tap to add more)',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              )*/
          ],
        );
      });
}
