import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sbarsmartbrainapp/auth.dart';
import 'package:sbarsmartbrainapp/global.dart';
import 'package:sbarsmartbrainapp/models/todo.dart';
import 'package:sbarsmartbrainapp/screens/patients/add/add_pt_frame.dart';
import 'package:sbarsmartbrainapp/screens/tasks/add_task.dart';
import 'package:sbarsmartbrainapp/services/backend.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';

import 'home.dart';

var pat;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var patients, nurses, tasks;
  int tasksNum = 0; // for analytics
  int patsNum = 0;
  List<Widget> widgets = [];

  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  CollectionReference get patientsCollection =>
      userDocument.collection('patients');
  CollectionReference get nurseCollection => userDocument.collection('nurses');
  CollectionReference get tasksCollection => userDocument.collection('tasks');

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenDashboard();
    /*Container(
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
        ),);*/ //gradient
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 768) {
        return StreamBuilder(
          initialData: SizedBox(),
          stream: Rx.combineLatest2(patientsCollection.get().asStream(),
              tasksCollection.get().asStream(), (dynamic a, dynamic b) {
            return (a.docs.length + b.docs.length);
          }),
          builder: (context, snapshot) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kDawnSky,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Card(
                        margin: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            // Dashboard Tile
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.circle,
                                  color: kDarkSky,
                                  size: 18.0,
                                ),
                                onPressed: () {},
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.circleInfo,
                                  color: kDarkSky,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  _screenGuide();
                                  CustomAnalytics().dialDashGuide();
                                },
                              ),
                              title: GestureDetector(
                                onTap: () {
                                  _premiumVersion();
                                  CustomAnalytics().dialDashPremGuide();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NurseBrain®',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: kDarkSky,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'SANDBOX',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: kDarkSky,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              tileColor: kDawnSky,
                              selectedTileColor: Colors.blue,
                            ),
                            // Patients Tile
                            StreamBuilder<QuerySnapshot>(
                                stream: Backend().patientStream1,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    patsNum = snapshot.data!.size;
                                    // print('patsNum = $patsNum');
                                  }
                                  return GestureDetector(
                                    child: !snapshot.hasData ||
                                            snapshot.data!.size == 0
                                        ? ListTile(
                                            tileColor: Colors.white,
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddPt();
                                              },
                                              icon: Icon(
                                                Icons.person_add_outlined,
                                                size: 26,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            title: Text(
                                              'Add a Patient',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            /*subtitle: Text(
                                              'You currently have ${!snapshot.hasData || snapshot.data == null ? 0 : snapshot.data.size} patient(s) assigned',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),*/
                                          )
                                        : ListTile(
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddPt();
                                              },
                                              icon: Icon(
                                                Icons.group,
                                                color: kDarkSky,
                                              ),
                                            ),
                                            title: Text(
                                              'Patients',
                                              style: kDashItemStyle,
                                            ),
                                            subtitle: Text(
                                              'You currently have ${!snapshot.hasData || snapshot.data == null ? 0 : snapshot.data!.size} patient(s) assigned',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    onTap: () {
                                      if (!snapshot.hasData ||
                                          snapshot.data!.size == 0) {
                                        _goToAddPt();
                                      } else {
                                        currentIndex = 1;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      }
                                    },
                                    onDoubleTap: () {
                                      _goToAddPt();
                                    },
                                    onLongPress: () {
                                      Backend().deleteAllPatients();
                                      CustomAnalytics()
                                          .eventDeleteAllPatients();
                                    },
                                  );
                                }),
                            // Tasks Tile
                            StreamBuilder<QuerySnapshot>(
                                stream: Backend().taskStream1,
                                builder: (context, snapshot) {
                                  late List<TodoClass> penTasks;
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    tasksNum = snapshot.data!.size;
                                    penTasks = snapshot.data!.docs
                                        .map((e) => TodoClass.fromMap(
                                            e.data() as Map<String, dynamic>))
                                        .where((w) => !w.isCompleted!)
                                        .toList();
                                  }
                                  return GestureDetector(
                                    child: !snapshot.hasData ||
                                            snapshot.data == null ||
                                            snapshot.data!.size == 0
                                        ? ListTile(
                                            tileColor: kJadeLake,
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddTask();
                                              },
                                              icon: Icon(
                                                Icons.add_alert,
                                                size: 26,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            title: Text(
                                              'Add a Task/Med Reminder',
                                              style: kStackHeaderStyle,
                                            ),
                                            /*subtitle: Text(
                                        'You currently have ${!snapshot.hasData || snapshot.data == null ? 0 : snapshot.data.size} task(s) remaining',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),*/
                                          )
                                        : ListTile(
                                            tileColor: kJadeLake,
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddTask();
                                              },
                                              icon: Icon(
                                                Icons.notifications,
                                                color: kDarkSky,
                                              ),
                                            ),
                                            title: Text(
                                              'Todo List',
                                              style: kDashItemStyle,
                                            ),
                                            subtitle: Text(
                                              'You currently have ${penTasks.isEmpty ? 0 : penTasks.length} task(s) remaining',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    onTap: () {
                                      if (!snapshot.hasData ||
                                          snapshot.data == null ||
                                          snapshot.data!.size == 0) {
                                        _goToAddTask();
                                      } else {
                                        currentIndex = 2;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                        );
                                      }
                                    },
                                    onDoubleTap: () {
                                      _goToAddTask();
                                    },
                                    onLongPress: () {
                                      Backend().deleteAllTasks();
                                      CustomAnalytics().eventDeleteAllTasks();
                                    },
                                  );
                                }),
                            // Share Tile
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.recycle,
                                  color: kDarkSky,
                                ),
                                onPressed: () {},
                              ),
                              title: Text(
                                'Tell a Friend',
                                style: kDashItemStyle,
                              ),
                              subtitle: Text(
                                'Help reduce paper report sheets',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kMidNightSkyBlend,
                                ),
                              ),
                              onTap: () {
                                _shareApp(context);
                                CustomAnalytics().eventTellFriend();
                              },
                              tileColor: kOceanSky,
                              selectedTileColor: Colors.blue,
                            ),
                            // End Shift Tile
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.stop,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                              title: Text(
                                'Tap to End Shift',
                                style: kDashItemStyle,
                              ),
                              subtitle: Text(
                                '(hold to clear all patient data)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kMidNightSkyBlend,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              onTap: () async {
                                await Auth().logout();
                                CustomAnalytics()
                                    .eventEndShift(patsNum, tasksNum);
                              },
                              tileColor: Colors.yellow[700],
                              selectedTileColor: Colors.blue,
                              onLongPress: () async {
                                CustomAnalytics()
                                    .eventDeleteShiftData(patsNum, tasksNum);
                                await Backend().deleteAllNurses();
                                await Backend().deleteAllTasks();
                                await Backend().deleteAllPatients();
                                await Auth().logout();
                                CustomAnalytics()
                                    .eventEndShift(patsNum, tasksNum);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kDawnSky,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Card(
                        margin: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            // Dashboard Tile
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.circle,
                                  color: kDarkSky,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  _premiumVersion();
                                },
                              ),
                              trailing: IconButton(
                                icon: Tooltip(
                                  message: 'How to use the dashboard',
                                  child: Icon(
                                    FontAwesomeIcons.circleInfo,
                                    color: kDarkSky,
                                    size: 18.0,
                                  ),
                                ),
                                onPressed: () {
                                  _screenGuide();
                                },
                              ),
                              title: GestureDetector(
                                onTap: () {
                                  _premiumVersion();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NurseBrain®',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: kDarkSky,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'SANDBOX',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: kDarkSky,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              tileColor: kDawnSky,
                              selectedTileColor: Colors.blue,
                            ),
                            // Patients Tile
                            StreamBuilder<QuerySnapshot>(
                                stream: Backend().patientStream1,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    patsNum = snapshot.data!.size;
                                    // print('patsNum = $patsNum');
                                  }
                                  return GestureDetector(
                                    child: !snapshot.hasData ||
                                            snapshot.data!.size == 0
                                        ? ListTile(
                                            tileColor: Colors.white,
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddPt();
                                              },
                                              icon: Icon(
                                                Icons.person_add_outlined,
                                                size: 26,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                _goToAddPt();
                                              },
                                              icon: Icon(
                                                (FontAwesomeIcons.plus),
                                                color: Colors.blue,
                                              ),
                                            ),
                                            title: Text(
                                              'Add a Patient',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            /*subtitle: Text(
                                              'You currently have ${!snapshot.hasData || snapshot.data == null ? 0 : snapshot.data.size} patient(s) assigned',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),*/
                                          )
                                        : ListTile(
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddPt();
                                              },
                                              icon: Icon(
                                                Icons.group,
                                                color: kDarkSky,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                _goToAddPt();
                                              },
                                              icon: Icon(
                                                (FontAwesomeIcons.plus),
                                                color: Colors.blue,
                                              ),
                                            ),
                                            title: Text(
                                              'Patients',
                                              style: kDashItemStyle,
                                            ),
                                            subtitle: Text(
                                              'You currently have ${!snapshot.hasData || snapshot.data == null ? 0 : snapshot.data!.size} patient(s) assigned',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    onTap: () {
                                      if (!snapshot.hasData ||
                                          snapshot.data!.size == 0) {
                                        _goToAddPt();
                                      } else {
                                        currentIndex = 1;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      }
                                    },
                                    onDoubleTap: () {
                                      _goToAddPt();
                                    },
                                    onLongPress: () {
                                      Backend().deleteAllPatients();
                                      CustomAnalytics()
                                          .eventDeleteAllPatients();
                                    },
                                  );
                                }),
                            // Tasks Tile
                            StreamBuilder<QuerySnapshot>(
                                stream: Backend().taskStream1,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    tasksNum = snapshot.data!.size;
                                  }
                                  late List<TodoClass> penTasks = snapshot
                                      .data!.docs
                                      .map((e) => TodoClass.fromMap(
                                          e.data() as Map<String, dynamic>))
                                      .where((w) => !w.isCompleted!)
                                      .toList();
                                  return GestureDetector(
                                    child: !snapshot.hasData ||
                                            snapshot.data == null ||
                                            snapshot.data!.size == 0
                                        ? ListTile(
                                            tileColor: kJadeLake,
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddTask();
                                              },
                                              icon: Icon(
                                                Icons.add_alert,
                                                size: 26,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                _goToAddTask();
                                              },
                                              icon: Icon(
                                                (FontAwesomeIcons.plus),
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              'Add a Task/Med Reminder',
                                              style: kStackHeaderStyle,
                                            ),
                                            /*subtitle: Text(
                                        'You currently have ${!snapshot.hasData || snapshot.data == null ? 0 : snapshot.data.size} task(s) remaining',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),*/
                                          )
                                        : ListTile(
                                            tileColor: kJadeLake,
                                            leading: IconButton(
                                              onPressed: () {
                                                _goToAddTask();
                                              },
                                              icon: Icon(
                                                Icons.notifications,
                                                color: kDarkSky,
                                              ),
                                            ),
                                            title: Text(
                                              'Todo List',
                                              style: kDashItemStyle,
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                _goToAddTask();
                                              },
                                              icon: Icon(
                                                (FontAwesomeIcons.plus),
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Text(
                                              'You currently have ${penTasks.isEmpty ? 0 : penTasks.length} task(s) remaining',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    onTap: () {
                                      if (!snapshot.hasData ||
                                          snapshot.data == null ||
                                          snapshot.data!.size == 0) {
                                        _goToAddTask();
                                      } else {
                                        currentIndex = 2;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                        );
                                      }
                                    },
                                    onDoubleTap: () {
                                      _goToAddTask();
                                    },
                                    onLongPress: () {
                                      Backend().deleteAllTasks();
                                      CustomAnalytics().eventDeleteAllTasks();
                                    },
                                  );
                                }),
                            // Share Tile
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.recycle,
                                  color: kDarkSky,
                                ),
                                onPressed: () {},
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.solidShareFromSquare,
                                  color: kDarkSky,
                                ),
                                onPressed: () {},
                              ),
                              title: Text(
                                'Tell a Friend',
                                style: kDashItemStyle,
                              ),
                              subtitle: Text(
                                'Help reduce the amount of paper report sheets',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kMidNightSkyBlend,
                                ),
                              ),
                              onTap: () {
                                _shareApp(context);
                                CustomAnalytics().eventTellFriend();
                              },
                              tileColor: kOceanSky,
                              selectedTileColor: Colors.blue,
                            ),
                            // End Shift Tile
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.stop,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.solidHandPeace,
                                  color: kDarkSky,
                                ),
                                onPressed: () {},
                              ),
                              title: Text(
                                'Tap to End Shift',
                                style: kDashItemStyle,
                              ),
                              subtitle: Text(
                                '(Press & hold to clear all patient data and logout of the app)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kMidNightSkyBlend,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              onTap: () async {
                                await Auth().logout();
                                CustomAnalytics()
                                    .eventEndShift(patsNum, tasksNum);
                              },
                              tileColor: Colors.yellow[700],
                              selectedTileColor: Colors.blue,
                              onLongPress: () async {
                                CustomAnalytics()
                                    .eventDeleteShiftData(patsNum, tasksNum);
                                await Backend().deleteAllNurses();
                                await Backend().deleteAllTasks();
                                await Backend().deleteAllPatients();
                                await Auth().logout();
                                CustomAnalytics()
                                    .eventEndShift(patsNum, tasksNum);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  // Functions

  _goToAddPt() async {
    final addPt = await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SbarAdd(),
      ),
    );
    if (addPt == 1) {
      setState(() {
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
        currentIndex = 1;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {}
  }

  _goToAddTask() async {
    final addTask = await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AddTask(),
      ),
    );
    if (addTask == 1) {
      currentIndex = 2;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      currentIndex = 2;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  _screenGuide() {
    bool wideScreen = MediaQuery.of(context).size.width > 768;
    Widget _content = Container(
      height: wideScreen && UniversalPlatform.isWeb ? 350 : 150,
      width: wideScreen && UniversalPlatform.isWeb ? 300 : 100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patients Tile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Tap once to view patients'),
            Text('Double tap to add a patient'),
            SizedBox(
              height: 12.0,
            ),
            Text(
              'Todo Tile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Tap once to view todo list'),
            Text('Double tap to add a new task'),
            SizedBox(
              height: 12.0,
            ),
            if (wideScreen && UniversalPlatform.isWeb)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keyboard Shortcuts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Alt + N = Add New Patient'),
                  Text('Alt + T = Add New Task'),
                  Text('Alt + P = Print / Share Report Sheet'),
                  Text('Alt + W = Write Custom Note'),
                  Text('Alt + 1 = View Dashboard'),
                  Text('Alt + 2 = View Patients'),
                  Text('Alt + 3 = View Todo List'),
                  Text('Alt + 4 = View Briefcase'),
                  Text('Alt + 5 = View Custom Notes'),
                  Text('Alt + L = Logout'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _premiumVersion() {
    bool wideScreen = MediaQuery.of(context).size.width > 768;
    Widget _content = Container(
      height: wideScreen && UniversalPlatform.isWeb ? 150 : 150,
      width: wideScreen && UniversalPlatform.isWeb ? 100 : 100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Thank you for using NurseBrain®. Your premium membership helps us continue providing first class tools to help you stay organized and on time throughout your shift.'),
          ],
        ),
      ),
    );
  }

  void _shareApp(BuildContext context) async {
    List _links = [
      'https://play.google.com/store/apps/details?id=samucreates.sbarsmartbrainapp',
      'https://apps.apple.com/us/app/nursebrain/id1528871626',
      'https://nursebrain.app'
    ];
    late int _type;
    if (UniversalPlatform.isWeb) {
      _type = 2;
    } else if (UniversalPlatform.isAndroid) {
      _type = 0;
    } else if (UniversalPlatform.isIOS) {
      _type = 1;
    }
    String message =
        'Checkout NurseBrain, the nurse workflow app I\'m using to stay organized during my shift! ${_links[_type]}';
    final box = context.findRenderObject() as RenderBox;
    Share.share(message,
        subject: 'My NurseBrain',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
