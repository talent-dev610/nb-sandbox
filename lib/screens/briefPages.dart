import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/auth.dart';
import 'package:sbarsmartbrainapp/edit_profile.dart';
import 'package:sbarsmartbrainapp/profile.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global.dart';
import '../note/note_list.dart';
import 'home/home.dart';
import 'tools.dart';

class NewPage extends StatefulWidget {
  @override
  NewPageState createState() => NewPageState();
}

class NewPageState extends State<NewPage> {
  bool _isInAsyncCall = false;
  final List<Tab> myTabs = <Tab>[
    // new Tab(text: 'Profile'),
    new Tab(text: 'Tools'),
    new Tab(text: 'My Notes'),
  ];
  PanelController settingController = new PanelController();
  Widget? temp;
  bool profileExist = false;

  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  CollectionReference get profileCollection =>
      userDocument.collection('profiles');

  Future<void> deleteAccount() async {
    var snapshots = await userDocument.collection("notes").get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    var snapshots1 = await userDocument.collection("profiles").get();
    for (var doc in snapshots1.docs) {
      await doc.reference.delete();
    }
    var snapshots2 = await userDocument.collection("tasks").get();
    for (var doc in snapshots2.docs) {
      await doc.reference.delete();
    }
    var snapshots3 = await userDocument.collection("nurses").get();
    for (var doc in snapshots3.docs) {
      await doc.reference.delete();
    }
    var snapshots4 = await userDocument.collection("patients").get();
    for (var doc in snapshots4.docs) {
      await doc.reference.delete();
    }
    Auth().logout();
    setState(() {
      _isInAsyncCall = false;
      settingController.close();
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void checkExist() {
    profileCollection.get().then((value) {
      print("-------------");
      if (value.size == 0) {
        setState(() {
          temp = EditProfilePage();
          profileExist = false;
        });
      } else {
        setState(() {
          temp = ProfilePage(
            id: value.docs.first.id,
          );
          profileExist = true;
        });
      }
    });
  }

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  showAlertDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      "Are you sure you want to permanently delete your account?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            // padding: EdgeInsets.only(left: 20, right:20),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFF34C759),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _isInAsyncCall = true;
                            });
                            deleteAccount();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Container(
                            // padding: EdgeInsets.only(left: 20, right: 20),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFF34C759),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "No",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }));
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    checkExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent,
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: myTabs,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 14),
            indicatorColor: Colors.blue,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: kMidNightSkyBlend,
                ),
                onPressed: () {
                  settingController.open();
                })
          ],
        ),
        body: Stack(
          children: [
            GestureDetector(
              child: TabBarView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [Briefcase(), NoteListPage()],
              ),
              onTap: () {
                settingController.close();
              },
            ),
            SlidingUpPanel(
                controller: settingController,
                minHeight: 0,
                maxHeight: height * 0.6,
                panelSnapping: true,
                defaultPanelState: PanelState.CLOSED,
                color: kVolcanoMist,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                panelBuilder: (ScrollController sc) => ListView(
                      controller: sc,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              settingController.close();
                            },
                          ),
                        ),
                        // Hipaa Compliance
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Settings",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: kDawnSky,
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                // Logout
                                GestureDetector(
                                  child: Container(
                                    height: 50,
                                    width: width * 0.6,
                                    // margin: EdgeInsets.only(left: 20),
                                    // padding:
                                    //     EdgeInsets.only(left: 20, right: 20),
                                    alignment: Alignment.center,
                                    color: Colors.blue[400],
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  onTap: () {
                                    logout() async {
                                      await Auth().logout();
                                    }

                                    logout();
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Hipaa Compliance
                                GestureDetector(
                                  child: Container(
                                    height: 50,
                                    width: width * 0.6,
                                    // margin: EdgeInsets.only(left: 20),
                                    // padding:
                                    //     EdgeInsets.only(left: 20, right: 20),
                                    alignment: Alignment.center,
                                    color: Colors.blue[400],
                                    child: Text(
                                      "HIPAA Compliance",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  onTap: () {
                                    _hipaaGuide();
                                    // settingController.close();
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Terms & Conditions
                                GestureDetector(
                                  child: Container(
                                    height: 50,
                                    width: width * 0.6,
                                    // margin: EdgeInsets.only(left: 20),
                                    // padding:
                                    //     EdgeInsets.only(left: 20, right: 20),
                                    alignment: Alignment.center,
                                    color: Colors.blue[400],
                                    child: Text(
                                      "Terms & Conditions",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  onTap: () {
                                    launchURL("https://nursebrain.com/terms/");
                                    settingController.close();
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Privacy Policy
                                GestureDetector(
                                  child: Container(
                                    height: 50,
                                    width: width * 0.6,
                                    // margin: EdgeInsets.only(left: 20),
                                    // padding:
                                    // EdgeInsets.only(left: 20, right: 20),
                                    alignment: Alignment.center,
                                    color: Colors.blue[400],
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  onTap: () {
                                    launchURL(
                                        "https://nursebrain.com/privacy-policy/");
                                    settingController.close();
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Delete Account
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 50,
                                        width: width * 0.6,
                                        // margin: EdgeInsets.only(left: width*0.2),
                                        // padding:
                                        //     EdgeInsets.only(left: 20, right: 20),
                                        alignment: Alignment.center,
                                        color: Colors.blue[400],
                                        child: Text(
                                          "Delete account",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      onTap: () {
                                        settingController.close();
                                        if (profileExist) {
                                          showAlertDialog(context);
                                          // final snackBar = SnackBar(
                                          //   backgroundColor: kMidNightSkyBlend,
                                          //   content:
                                          //       Text('are you delete account ?'),
                                          //   action: SnackBarAction(
                                          //     label: 'Yes',
                                          //     onPressed: () {
                                          //       showAlertDialog(context);
                                          //     },
                                          //   ),
                                          // );
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(snackBar);
                                        } else {
                                          showAlertDialog(context);
                                          // alert(
                                          //     "you don't have profile. please create profile");
                                        }
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
          ],
        ),
      ),
    );
  }

  _hipaaGuide() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
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
        ),
        content: Container(
          height: 450,
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Text(
                      'NurseBrain does not request, use, or collect any Protected Health Information (PHI) or confidential patient identifiers (see chart below).\n\nSimilar to a traditional paper report sheet, it is the nurse\'s responsibility to make sure that no PHI is entered into the app. All data entered into this app is securely stored on Google cloud servers and can be deleted anytime by the nurse.',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DataTable(
                      columnSpacing: 10,
                      dataRowHeight: 90,
                      columns: [
                        DataColumn(
                          label: Container(
                            child: Text('Patient Information'),
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
                            DataCell(Text(
                                'Dates (except year) including admission dates, discharge dates, etc.')),
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
                            DataCell(
                                Text('Vehicle identifiers and serial numbers')),
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
                            DataCell(
                                Text('Device identifiers and serial numbers')),
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
                            DataCell(
                                Text('Full face photos and comparable images')),
                            DataCell(Text('No')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(
                                'Biometric identifiers (i.e. retinal scan, fingerprints)')),
                            DataCell(Text('No')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(
                                Text('Any unique identifying number or code')),
                            DataCell(Text('No')),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
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
}
