import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:sbarsmartbrainapp/extra/share_dialog.dart';
import 'package:sbarsmartbrainapp/qr_share.dart';
import 'package:sbarsmartbrainapp/screens/home/welcome.dart';
import 'package:sbarsmartbrainapp/screens/tasks/todo_screen.dart';
import 'package:sbarsmartbrainapp/services/backend.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../auth.dart';
import '../../global.dart';
import '../../models/patients/patient.dart';
import '../../services/backend.dart';
import '../../supps/constants.dart';
import '../authentication/login.dart';
import '../briefPages.dart';
import '../clip_board.dart' as cb;
import '../patients/add/add_pt_frame.dart';
import '../tasks/add_task.dart';
import '../tasks/todo_screen.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  PageController? _pageController;
  var patients, nurses, tasks;
  List<Widget> widgets = [];
  List<LogicalKeyboardKey> keys = [];

  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  CollectionReference get patientsCollection =>
      userDocument.collection('patients');
  CollectionReference get nurseCollection => userDocument.collection('nurses');
  CollectionReference get tasksCollection => userDocument.collection('tasks');

  void initState() {
    // Count number of app launches
    _launchCounter();
    // Launch D

    _pageController = PageController(initialPage: currentIndex);
    getData();
    // Rate my app prompt
    rateMyApp.init().then(
      (_) {
        if (rateMyApp.shouldOpenDialog && !UniversalPlatform.isWeb) {
          rateMyApp.showStarRateDialog(
            context,
            title: 'Enjoying NurseBrain?',
            message:
                'Please take a few seconds to review us. It keeps us super motivated and helps us keep growing!',
            actionsBuilder: (context, stars) {
              // Triggered when the user updates the star rating.
              return [
                // Return a list of actions (that will be shown at the bottom of the dialog).
                TextButton(
                  child: Text('Leave Review!'),
                  onPressed: () async {
                    if (stars != null) {
                      if (stars >= 4) {
                        UniversalPlatform.isIOS
                            ? launch(
                                'https://apps.apple.com/us/app/nursebrain/id1528871626')
                            : launch(
                                'https://play.google.com/store/apps/details?id=samucreates.sbarsmartbrainapp');
                        CustomAnalytics().eventAppReview();
                      } else {
                        launch(kFeedbackUrl);
                        CustomAnalytics().eventFeedbackForm();
                      }
                      // triggers "Do Not Show Again" after rating
                      final rated = RateMyAppEventType.rateButtonPressed;
                      await rateMyApp.callEvent(rated);
                      rateMyApp.save().then((value) => Navigator.pop(context));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ];
            },
            dialogStyle: DialogStyle(
              // messageStyle: TextStyle(
              //   fontSize: 18.0,
              // ),
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20.0),
            ),
            ignoreNativeDialog: true,
            onDismissed: () =>
                rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
          );
        }
      },
    );
    super.initState();
  }

  // Rate App
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
  );

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // Design Scheme
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [kDarkSky, kNightSky, kNoonSky, kOceanSky, kDarkSky],
          stops: [0.1, 0.2, 0.5, 0.9, 1.0],
        ),
      ),
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if not logged in to database
          if (snapshot == null || snapshot.data == null) {
            guest = true;
            CustomAnalytics().propUserGuest();
            // display clipboard if guest has a patient
            if (guest && prefs!.getString('guestPatient') == null) {
              return SafeArea(left: false, right: false, child: SbarAdd());
            } else
              return SafeArea(left: false, right: false, child: Login());
          } else {
            Auth().init();
            // user is not a guest if logged in
            guest = false;
            kUserID = snapshot.data!.uid;
            CustomAnalytics().propUserID(kUserID); // id in users collection
            // user is now a member, not a guest
            CustomAnalytics().propUserNurse();
            return SafeArea(
              left: false,
              right: false,
              child: RawKeyboardListener(
                autofocus: true,
                focusNode: FocusNode(),
                onKey: (event) {
                  final key = event.logicalKey;
                  // Keyboard shortcuts
                  if (event is RawKeyDownEvent) {
                    if (keys.contains(key)) return;
                    if (event.isKeyPressed(LogicalKeyboardKey.altLeft)) {
                      // New patient
                      if (event.isKeyPressed(LogicalKeyboardKey.keyN)) {
                        currentIndex = 1;
                        if (!UniversalPlatform.isWeb &&
                            MediaQuery.of(context).size.height < 768) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SbarAdd(),
                            ),
                          );
                        }
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SbarAdd(),
                          ),
                        );
                      }
                      // New task
                      if (event.isKeyPressed(LogicalKeyboardKey.keyT)) {
                        currentIndex = 2;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddTask()),
                        );
                      }
                      // Share report
                      if (event.isKeyPressed(LogicalKeyboardKey.keyP)) {
                        share() async {
                          List<Patient> patients =
                              await Backend().getPatients();
                          QRShare().init(patients);
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots()
                              .listen((event) async {
                            Map<String, dynamic> data = event.data()!;
                            if (data['is_sharing'] && QRShare().isQRVisible!) {
                              print('Inside stream listen!');
                              print(data);
                              Navigator.of(context).pop();
                              QRShare().isQRVisible = false;
                              await event.reference.set({'is_sharing': false},
                                  SetOptions(merge: true));
                            } else if (data['is_sharing']) {
                              await event.reference.set({'is_sharing': false},
                                  SetOptions(merge: true));
                            }
                          });
                          await showDialog(
                            context: context,
                            builder: (context) => ShareDialog(patients),
                          );
                        }

                        share();
                      }
                      // Logout
                      if (event.isKeyPressed(LogicalKeyboardKey.keyL)) {
                        logout() async {
                          await Auth().logout();
                        }

                        logout();
                      }
                      // Goto Home
                      if (event.isKeyPressed(LogicalKeyboardKey.digit1)) {
                        currentIndex = 0;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                      // Goto Clipboard
                      if (event.isKeyPressed(LogicalKeyboardKey.digit2)) {
                        currentIndex = 1;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Welcome()),
                        );
                      }
                      // Goto Tasks
                      if (event.isKeyPressed(LogicalKeyboardKey.digit3)) {
                        currentIndex = 2;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                      // Goto Briefcase
                      if (event.isKeyPressed(LogicalKeyboardKey.digit4)) {
                        currentIndex = 3;
                        initialIndex = 0;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    }
                    setState(() {
                      keys.add(key);
                    });
                  } else {
                    setState(() {
                      keys.remove(key);
                    });
                  }
                },
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: //_widgetOptions.elementAt(_selectedIndex),
                      PageView(
                    // physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    children: [
                      Dashboard(),
                      cb.Clipboard(),
                      TodoScreen(),
                      NewPage(),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    height: 60.0,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/smileys.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: BottomNavyBar(
                        iconSize: 30.0,
                        backgroundColor: Colors.transparent,
                        showElevation: false,
                        selectedIndex: currentIndex,
                        onItemSelected: (index) {
                          setState(() {
                            currentIndex = index;
                            if (index == 3) {
                              initialIndex = initialIndex;
                            }
                          });
                          _pageController!.jumpToPage(index);
                          getData();
                        },
                        items: [
                          BottomNavyBarItem(
                            icon: Icon(
                              FontAwesomeIcons.hospitalSymbol,
                              color: kMidNightSkyBlend,
                            ),
                            title: Text(
                              ' Home',
                              style: TextStyle(color: kMidNightSkyBlend),
                            ),
                            activeColor: kNoonSky,
                          ),
                          BottomNavyBarItem(
                              icon: Icon(
                                FontAwesomeIcons.clipboardUser,
                                color: kMidNightSkyBlend,
                              ),
                              title: Text(
                                'Clipboard',
                                style: TextStyle(color: kMidNightSkyBlend),
                              ),
                              activeColor: kNoonSky),
                          BottomNavyBarItem(
                              icon: Icon(
                                FontAwesomeIcons.solidRectangleList,
                                color: kMidNightSkyBlend,
                              ),
                              title: Text(
                                'Todo',
                                style: TextStyle(color: kMidNightSkyBlend),
                              ),
                              activeColor: kNoonSky),
                          BottomNavyBarItem(
                              icon: Icon(
                                FontAwesomeIcons.briefcaseMedical,
                                color: kMidNightSkyBlend,
                              ),
                              title: Text(
                                'Briefcase',
                                style: TextStyle(color: kMidNightSkyBlend),
                              ),
                              activeColor: kNoonSky),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('patients')
          .get()
          .then((value) {
        setState(() {
          patients = value.docs.length;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tasks')
            .get()
            .then((value2) {
          setState(() {
            tasks = value2.docs.length;
          });
        });
      });

      // Get nurse's name
      nurseName = FirebaseAuth.instance.currentUser!.displayName;
      // print('My name is $nurseName');
    }
  }

  // App launch count function
  _launchCounter() async {
    int _launchCount = (prefs!.getInt('launchCount') ?? 0) + 1;
    print('App has been launched $_launchCount times.');
    await prefs!.setInt('launchCount', _launchCount);
  }
}
