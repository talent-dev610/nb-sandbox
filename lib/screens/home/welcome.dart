import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../patients/add/add_pt_frame.dart';
import '../tasks/add_task.dart';
import '../../extra/scan.dart';
import '../../global.dart';
import 'home.dart';
import 'package:universal_platform/universal_platform.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {

  bool showcasePossible = true;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kDarkSky,
              kNightSky,
              kNoonSky,
              kOceanSky
            ],
            stops: [0.1, 0.5, 0.8, 1.0],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0, bottom: 8.0, left: 8.0, right: 8.0),
              child: Container(
                // margin: EdgeInsets.only(left: 10, right: 10, top: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kLavenSky,
                      // Colors.deepPurpleAccent[400],
                      kDawnSky,
                      kNoonSky,
                    ],
                    stops: [0.1, 0.4, 0.8],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome to NurseBrain!",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: _goToAddPt,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Get Started",
                                      style: kWelcomeItemStyle,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Add patient, QR
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(color: kJadeLake, borderRadius: BorderRadius.circular(5)),
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Add Patient",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    if (!UniversalPlatform.isWeb)
                                      GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(color: kJadeLake, borderRadius: BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Scan QR",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          _goToQR();
                                        },
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),),
                      ),
                      // Add Task, Medication
                      Card(
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Stay organized
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "Stay Organized",
                                    style: kWelcomeItemStyle,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Add Task, Medication
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  GestureDetector(
                                    onTap: _goToAddTask,
                                    child: Container(
                                      decoration: BoxDecoration(color: kJadeLake, borderRadius: BorderRadius.circular(5)),
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Add Med/Task",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  // if (!UniversalPlatform.isWeb)
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(color: kJadeLake, borderRadius: BorderRadius.circular(5)),
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Write Note",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _goToAddNote();
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),),
                      // Hippa Compliance
                      ExpandableNotifier(
                        child: Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Column(
                              children: [
                                ScrollOnExpand(
                                  scrollOnExpand: true,
                                  scrollOnCollapse: false,
                                  child: ExpandablePanel(
                                    theme: ExpandableThemeData(
                                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                                      tapBodyToExpand: true,
                                      tapBodyToCollapse: true,
                                    ),
                                    header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.userLock,
                                              color: kRichGrass,
                                            ),
                                            Text(
                                              'Fully HIPAA Compliant',
                                              style: kWelcomeItemStyle,
                                            ),
                                          ],
                                        )),
                                    collapsed: Text(
                                      'NurseBrain does not request, use, or collect any Protected Health Information (PHI) or confidential patient identifiers.',
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    expanded: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SingleChildScrollView(
                                          child: Column(children: <Widget>[
                                            Text(
                                              'NurseBrain does not request, use, or collect any Protected Health Information (PHI) or confidential patient identifiers (see chart below).\n\nSimilar to a traditional paper report sheet, it is the nurse\'s responsibility to make sure that no PHI is entered into the app. All data entered into this app is securely stored on Google cloud servers and can be deleted anytime by the nurse.',
                                              softWrap: true,
                                            ),
                                            DataTable(
                                              columnSpacing: 10,
                                              dataRowHeight: 90,
                                              columns: [
                                                DataColumn(
                                                  label: Container(
                                                    child: Text('Patient Identifiers'),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text('Collected?'),
                                                ),
                                              ],
                                              rows: [
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Names')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Ages (> 89)')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Dates (except year) including admission dates, discharge dates, etc.')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Telephone numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Geographic data')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('FAX numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Social Security numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Email addresses')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Medical record numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Account numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Health plan beneficiary numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Certificate/license numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Vehicle identifiers and serial numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Web / Social Media URLs')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Device identifiers and serial numbers')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Internet protocol addresses')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Full face photos and comparable images')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Biometric identifiers (i.e. retinal scan, fingerprints)')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(Text('Any unique identifying number or code')),
                                                    DataCell(Text('No')),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                    builder: (_, collapsed, expanded) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                        child: Expandable(
                                          collapsed: collapsed,
                                          expanded: expanded,
                                          theme: const ExpandableThemeData(crossFadePoint: 0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // No phone policy card
                      if (!UniversalPlatform.isWeb)
                        Card(
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "No Phone Policy at Work?",
                                  style: kWelcomeItemStyle,
                                ),
                                ListTile(
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.mouse,
                                      color: kDarkSky,
                                      size: 33.0,
                                    ),
                                    onPressed: () {
                                      launch('https://nursebrain.app/');
                                    },
                                  ),
                                  title: Text(
                                    "Go to nursebrain.app from your work computer browser to access your report sheet!",
                                    style: TextStyle(
                                      color: kDarkSky,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  tileColor: Colors.yellow[700],
                                  selectedTileColor: Colors.blue,
                                  onTap: () {
                                    launch('https://nursebrain.app/');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      // App available
                      if (UniversalPlatform.isWeb)
                        Card(
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "Get the Mobile App!",
                                  style: kWelcomeItemStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListTile(
                                  leading: IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.mobileAlt,
                                      color: kDarkSky,
                                      size: 33.0,
                                    ),
                                    onPressed: () {},
                                  ),
                                  title: Text(
                                    "NurseBrain is also available as a mobile app. Download Now!",
                                    style: TextStyle(
                                      color: kDarkSky,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  tileColor: Colors.yellow[700],
                                  selectedTileColor: Colors.blue,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                // App Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    // Apple Download
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        primary: kNoonSky,
                                      ),
                                      onPressed: () {
                                        launch('https://apps.apple.com/us/app/nursebrain/id1528871626');
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(FontAwesomeIcons.appStoreIos),
                                      ),
                                      label: Text('Apple'),
                                    ),
                                    // Android Download
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        primary: kNoonSky,
                                      ),
                                      onPressed: () {
                                        launch('https://play.google.com/store/apps/details?id=samucreates.sbarsmartbrainapp');
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(FontAwesomeIcons.googlePlay),
                                      ),
                                      label: Text('Android'),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// nav functions
  _goToAddPt() async {
    final addPt = await Navigator.of(context).push(
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      print('patient not saved');
    }
  }

  _goToQR() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QRScan(),
      ),
    );
    currentIndex = 1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  _goToAddNote() {
    currentIndex = 3;
    initialIndex = 1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  _goToAddTask() async {
    final addTask = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddTask(),
      ),
    );
    if (addTask == 1) {
      currentIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print('todo not saved');
    }
  }
}