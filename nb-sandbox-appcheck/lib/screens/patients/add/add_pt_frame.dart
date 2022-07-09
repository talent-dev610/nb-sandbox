import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/models/assessments/dropdowns/specialties.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:sbarsmartbrainapp/screens/patients/add/add_patient_form.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/supps/sbar_form_fields.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../global.dart';
import '../../../supps/constants.dart';

class SbarAdd extends StatefulWidget {
  @override
  _SbarAddState createState() => _SbarAddState();
}

class _SbarAddState extends State<SbarAdd> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'add pt scaffold');
  AnimationController? controller;

  final SpecialsDropDown _specialtiesDropDown = SpecialsDropDown();

  //Specialty widget list initial value
  List<String> Specialty = [
    'Antepartum',
    'Gynecology',
    'Intensive Care',
    'MedSurg / Tele',
    'Pediatrics',
    'Postpartum',
    'Psychiatry',
  ];

//Specialty initial value
  String? selectedSpecialty = "MedSurg / Tele";
  Widget? firstWidget;

//select Specialty function
  void setSpecialty(String string) {
    print(string);
    setState(() {
      selectedSpecialty = string;
      widgetList = [
        AddPatientForm(
          selectedSpecialty: "Antepartum",
        ),
        AddPatientForm(
          selectedSpecialty: "Gynecology",
        ),
        AddPatientForm(
          selectedSpecialty: "Intensive Care",
        ),
        AddPatientForm(
          selectedSpecialty: "MedSurg / Tele",
        ),
        AddPatientForm(
          selectedSpecialty: "Pediatrics",
        ),
        AddPatientForm(
          selectedSpecialty: "Postpartum",
        ),
        AddPatientForm(
          selectedSpecialty: "Psychiatry",
        ),
      ];
      tempWidget = widgetList[Specialty.indexOf(string)];
      print(tempWidget);
    });
  }

  void shareSpecialty(String str) async {
    await prefs!.setString("Specialty", str);
  }

  Future<String?> getSpecialty() async {
    String? specialty;
    if (prefs!.containsKey('Specialty')) {
      print(prefs!.get('Specialty'));
      if (prefs!.get('Specialty') != 'null') {
        specialty = prefs!.get('Specialty') as String?;
      } else {
        specialty = "MedSurg / Tele";
      }
    } else {
      specialty = "MedSurg / Tele";
    }
    // print("==============>" + specialty!);
    setState(() {
      tempWidget = widgetList[Specialty.indexOf(specialty!)];
      selectedSpecialty = specialty;
    });
    return specialty;
  }

  void initState() {
    // Show welcome/intro dialog
    if (prefs!.getInt('launchCount')! < 2 && guest) {
      print('guest is $guest');
      SchedulerBinding.instance
          .addPostFrameCallback((_) => _welcomeGuide(context));
    } else {
      noShowCase();
    }
    setState(() {
      //Specialty init
      selectedSpecialty = "MedSurg / Tele";
      //Specialty widgets init
      widgetList = [
        AddPatientForm(
          selectedSpecialty: "Antepartum",
        ),
        AddPatientForm(
          selectedSpecialty: "Gynecology",
        ),
        AddPatientForm(
          selectedSpecialty: "Intensive Care",
        ),
        AddPatientForm(
          selectedSpecialty: "MedSurg / Tele",
        ),
        AddPatientForm(
          selectedSpecialty: "Pediatrics",
        ),
        AddPatientForm(
          selectedSpecialty: "Postpartum",
        ),
        AddPatientForm(
          selectedSpecialty: "Psychiatry",
        ),
      ];
    });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    setState(() {
      //first showing widget -> MedSurg
      getSpecialty();
      firstWidget = AddPatientForm(
        selectedSpecialty: selectedSpecialty!,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Widget? tempWidget;
  List<Widget> widgetList = [];
  final _show1 = GlobalKey(debugLabel: '_show1'); // add patient
  final _show4 = GlobalKey(debugLabel: 'show4'); // bottom nav

  BuildContext? myContext;
  @override
  Widget build(BuildContext context) {
    return doShowCase && guest
        ? ShowCaseWidget(builder: Builder(
            builder: (context) {
              myContext = context;
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
                    key: _scaffoldKey,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      actions: [
                        // Login
                        guest
                            ? Showcase(
                                key: _show4,
                                title: 'Want more features?',
                                description:
                                    'Create a free account to add unlimited patients, medications, reminders & more!',
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: kOceanSky,
                                    size: 18.0,
                                  ),
                                  onPressed: () {
                                    noShowCase();
                                    showLogin(context);
                                  },
                                  tooltip: 'Sign in or create a free account',
                                ),
                              )
                            : // Close Screen
                            GestureDetector(
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.chevronCircleDown,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
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
                                            noShowCase();
                                            currentIndex = 1;
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                            );
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Keep Open'),
                                          onPressed: () {
                                            noShowCase();
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
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                },
                              ),
                      ],
                      title: /*guest
                      ? GestureDetector(
                          onTap: () {
                            showLogin(context);
                          },
                          child: Center(
                            child: Text(
                              'Enter Patient via SBAR',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      :*/
                          GestureDetector(
                        onTap: () {
                          // showAlertDialog(context);
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Select Specialty'),
                              content: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    SbarFFDrop(
                                      icon: FontAwesomeIcons.starOfLife,
                                      fieldLabel: 'Specialty',
                                      fieldValue: selectedSpecialty,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedSpecialty = value;
                                          specialtyChanged = true;
                                          Navigator.pop(context);
                                          shareSpecialty(selectedSpecialty!);
                                          print(Specialty.indexOf(
                                              selectedSpecialty!));
                                          setSpecialty(selectedSpecialty!);
                                        });
                                        CustomAnalytics().eventSwitchSpecialty(
                                            selectedSpecialty);
                                      },
                                      items:
                                          _specialtiesDropDown.specialsDropList,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            barrierDismissible: true,
                          );
                        },
                        child: Tooltip(
                          message: 'Tap here to switch specialties',
                          child: Showcase(
                            key: _show1,
                            title: 'Select specialty',
                            description:
                                'Choose your nursing floor or department',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedSpecialty!,
                                  style:
                                      TextStyle(fontSize: 20, color: kDawnSky),
                                ),
                                Text(
                                  " Patient",
                                  style: kFormHeaderStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                    ),
                    backgroundColor: Colors.transparent,
                    body: tempWidget != null ? tempWidget : firstWidget,
                  ),
                ),
              );
            },
          ))
        : Theme(
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
                key: _scaffoldKey,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    // Login
                    guest
                        ? IconButton(
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: kOceanSky,
                              size: 18.0,
                            ),
                            onPressed: () {
                              noShowCase();
                              showLogin(context);
                            },
                            tooltip: 'Sign in or create a free account',
                          )
                        : // Close Screen
                        GestureDetector(
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.circleChevronDown,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
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
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                          ),
                  ],
                  title: /*guest
                    ? GestureDetector(
                        onTap: () {
                          showLogin(context);
                        },
                        child: Center(
                          child: Text(
                            'Enter Patient via SBAR',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    :*/
                      GestureDetector(
                    onTap: () {
                      // showAlertDialog(context);
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Select Specialty'),
                          content: Container(
                            height: 100,
                            child: Column(
                              children: [
                                SbarFFDrop(
                                  icon: FontAwesomeIcons.starOfLife,
                                  fieldLabel: 'Specialty',
                                  fieldValue: selectedSpecialty,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSpecialty = value;
                                      specialtyChanged = true;
                                      Navigator.pop(context);
                                      shareSpecialty(selectedSpecialty!);
                                      print(Specialty.indexOf(
                                          selectedSpecialty!));
                                      setSpecialty(selectedSpecialty!);
                                    });
                                    CustomAnalytics().eventSwitchSpecialty(
                                        selectedSpecialty);
                                  },
                                  items: _specialtiesDropDown.specialsDropList,
                                ),
                              ],
                            ),
                          ),
                        ),
                        barrierDismissible: true,
                      );
                    },
                    child: Tooltip(
                      message: 'Tap here to switch specialties',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedSpecialty!,
                            style: TextStyle(fontSize: 20, color: kDawnSky),
                          ),
                          Text(
                            " Patient",
                            style: kFormHeaderStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
                backgroundColor: Colors.transparent,
                body: tempWidget != null ? tempWidget : firstWidget,
              ),
            ),
          );
  }

  // Show welcome pop up
  _welcomeGuide(context) {
    showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(
            'Welcome to NurseBrain™',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Container(
            height: 150,
            width: 300,
            child: Center(
              child: Text(
                  'NurseBrain™ is a nurse-made application used by over 10,000 nurses! We help you manage your patients & nursing tasks quickly & efficiently without compromising HIPAA or patient confidentiality.'),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Tap Here to Get Started!'),
              onPressed: () async {
                Navigator.pop(context);
                ShowCaseWidget.of(myContext!)!.startShowCase([
                  _show1,
                  show2,
                  show3,
                  _show4,
                ]);
              },
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
