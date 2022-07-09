import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'screens/briefPages.dart';
import 'supps/constants.dart';

import 'global.dart';
import 'models/ProfileModel.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  // TextEditingController hospitalController = new TextEditingController();
  List<TextEditingController> hospitalControllerList = [];

  final format = DateFormat("yyyy-MM-dd");

  String studentGroupValue = "Yes";
  List<String> _status = ["Yes", "No"];

  String? SpecialtyDropdownValue = 'MedSurg';
  List<String> Specialty = [
    'MedSurg',
    'Emergency',
    'Intensive Care',
    'Step Down',
    'Neonatal ICU',
    'Labor & Delivery',
    'Telemetry',
    'Pediatrics',
    'Psychiatry',
    'PACU'
  ];

  String ShiftLength = "8 hours";
  List<String> ShiftLengthList = ['8 hours', '10 hours', '12 hours'];

  String ScheduleType = "Per Diem";
  List<String> ScheduleTypeList = ['Per Diem', 'Part Time', 'Full Time'];

  String? DegreeDropdownValue = 'Associates';
  List<String> Degree = [
    'Associates',
    'Bachelors',
    'Masters',
    'Doctorate',
  ];

  List<String> checkedLicenseList = ['RN'];
  List<String> LicenseList = ['LVN/LPN', 'RN', 'ANP'];
  List<bool> licenseCheckFlag = [false, true, false];

  List<String> checkedCertificationsList = ['BLS'];
  List<String> CertificationsList = ['BLS', 'ACLS', 'PALS'];
  List<bool> certificationsCheckFlag = [true, false, false];

  List<String> workGroupValueList = [];
  List<List<String>> workStatusList = [];

  int jobCount = 1;
  DateTime? birthdayDate, graduationDate;
  List<DateTime?> startDateList = [];
  List<DateTime?> endDateList = [];

  ProfileModel profileModel = ProfileModel();
  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  CollectionReference get profileCollection =>
      userDocument.collection('profiles');

  bool _isInAsyncCall = false;

  Future<void> addProfile(ProfileModel profileModel) async {
    DocumentReference doc = await profileCollection.add(profileModel.toMap());
    doc.set({'id': doc.id}, SetOptions(merge: true)).then((value) {
      setState(() {
        print("=============");
        print(doc.id);
        print(FirebaseAuth.instance.currentUser!.uid);
        profileId = doc.id;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewPage(
                  // index: 0,
                  )),
        );
        _isInAsyncCall = false;
      });
    });
  }

  checkUsernameIsUnique(String username) async {
    QuerySnapshot querySnapshot;
    querySnapshot =
        await profileCollection.where("userName", isEqualTo: username).get();
    print(querySnapshot.docs.isNotEmpty);
    setState(() {
      _isInAsyncCall = false;
    });
    return querySnapshot.docs.isEmpty;
  }

  checkUserEmailIsUnique(String userEmail) async {
    QuerySnapshot querySnapshot;
    querySnapshot =
        await profileCollection.where("userEmail", isEqualTo: userEmail).get();
    print(querySnapshot.docs.isNotEmpty);
    setState(() {
      _isInAsyncCall = false;
    });
    return querySnapshot.docs.isEmpty;
  }

  @override
  void initState() {
    print(profileCollection.id);
    for (int i = 0; i < jobCount; i++) {
      hospitalControllerList.add(new TextEditingController());
      DateTime? temp;
      startDateList.add(temp);
      endDateList.add(temp);
      String workGroupValue = "Yes";
      List<String> workStatus = ["Yes", "No"];
      workGroupValueList.add(workGroupValue);
      workStatusList.add(workStatus);
    }
    // Specialty.sort();
    Degree.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.greenAccent])),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Username",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email address",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: DateTimeField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.date_range),
                    hintText: "Date of birth",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                format: format,
                onSaved: (val) => setState(() => birthdayDate = val),
                keyboardType: TextInputType.datetime,
                onChanged: (DateTime? newValue) {
                  setState(() {
                    birthdayDate = newValue;
                    print(birthdayDate);
                  });
                },
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Row(
                  children: [
                    Container(
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      width: width * 0.425,
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Container(
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Last Name",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      width: width * 0.425,
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Student",
                    style: TextStyle(fontSize: 16),
                  ),
                  // Container(
                  //   width: width * 0.6,
                  //   child: RadioGroup<String>.builder(
                  //     direction: Axis.horizontal,
                  //     groupValue: studentGroupValue,
                  //     onChanged: (value) => setState(() {
                  //       studentGroupValue = value;
                  //     }),
                  //     items: _status,
                  //     itemBuilder: (item) => RadioButtonBuilder(
                  //       item,
                  //     ),
                  //   ),
                  // ),
                  studentGroupValue == "Yes"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Graduation Date:"),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              width: width * 0.8,
                              child: DateTimeField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.date_range),
                                    hintText: "",
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                format: format,
                                resetIcon: null,
                                onSaved: (val) =>
                                    setState(() => graduationDate = val),
                                keyboardType: TextInputType.datetime,
                                onChanged: (DateTime? newValue) {
                                  setState(() {
                                    graduationDate = newValue;
                                    print(graduationDate);
                                  });
                                },
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                },
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            studentGroupValue == "Yes"
                ? const SizedBox()
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        width: width * 0.9,
                        // margin: EdgeInsets.only(left: width*0.05, right: width*0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Text(
                              "Specialty",
                              style: TextStyle(fontSize: 16),
                            ),
                            // DropdownButtonHideUnderline(
                            //   child:
                            DropdownButton<String>(
                              value: SpecialtyDropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 0,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  SpecialtyDropdownValue = newValue;
                                });
                              },
                              items: Specialty.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.9,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        // margin: EdgeInsets.only(left: width*0.05, right: width*0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Shift Length",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     RadioGroup<String>.builder(
                            //       direction: Axis.vertical,
                            //       groupValue: ShiftLength,
                            //       onChanged: (value) => setState(() {
                            //         ShiftLength = value;
                            //       }),
                            //       items: ShiftLengthList,
                            //       itemBuilder: (item) => RadioButtonBuilder(
                            //         item,
                            //       ),
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.9,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        // margin: EdgeInsets.only(left: width*0.05, right: width*0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // width: width*0.3,
                              child: Text(
                                "Schedule Type",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     RadioGroup<String>.builder(
                            //       direction: Axis.vertical,
                            //       groupValue: ScheduleType,
                            //       onChanged: (value) => setState(() {
                            //         ScheduleType = value;
                            //       }),
                            //       items: ScheduleTypeList,
                            //       itemBuilder: (item) => RadioButtonBuilder(
                            //         item,
                            //       ),
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.9,
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        // margin: EdgeInsets.only(left: width*0.05, right: width*0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Text(
                              "Degree ",
                              style: TextStyle(fontSize: 16),
                            ),
                            // SizedBox(width: width*0.1,),
                            // DropdownButtonHideUnderline(
                            //   child:
                            DropdownButton<String>(
                              value: DegreeDropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 0,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  DegreeDropdownValue = newValue;
                                });
                              },
                              items: Degree.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        margin: EdgeInsets.only(
                            left: width * 0.05, right: width * 0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: width*0.25,
                              child: Text(
                                "License",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /*CheckboxGroup(
                                  orientation:
                                      GroupedButtonsOrientation.VERTICAL,
                                  // margin: const EdgeInsets.only(left: 12.0),
                                  onSelected: (List selected) => setState(() {
                                    checkedLicenseList = selected;
                                  }),
                                  onChange: (bool isChecked, String label,
                                      int index) {
                                    print(
                                        "isChecked: $isChecked   label: $label  index: $index");
                                    setState(() {
                                      licenseCheckFlag[index] = isChecked;
                                    });
                                  },
                                  labels: LicenseList,
                                  checked: checkedLicenseList,
                                  itemBuilder: (Checkbox cb, Text txt, int i) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            // width: width*0.15,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                cb,
                                                Container(
                                                  // width: width*0.15,
                                                  child: txt,
                                                ),
                                              ],
                                            ),
                                          ),
                                          licenseCheckFlag[i]
                                              ? Container(
                                                  width: width * 0.5,
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      left: 12.0),
                                                  child: DateTimeField(
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        prefixIcon: Icon(
                                                            Icons.date_range),
                                                        hintText:
                                                            "Expiration date",
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        errorBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    Colors.grey),
                                                            borderRadius: BorderRadius.circular(10)),
                                                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10))),
                                                    format: format,
                                                    onShowPicker: (context,
                                                        currentValue) {
                                                      return showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime(1900),
                                                          initialDate:
                                                              currentValue ??
                                                                  DateTime
                                                                      .now(),
                                                          lastDate:
                                                              DateTime(2100));
                                                    },
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    );
                                  },
                                )*/
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.9,
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        // margin: EdgeInsets.only(left: width*0.05, right: width*0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Certifications",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            /*Container(
                              // width: width*0.3,
                              child: CheckboxGroup(
                                orientation: GroupedButtonsOrientation.VERTICAL,
                                // margin: const EdgeInsets.only(left: 12.0),
                                onSelected: (List selected) => setState(() {
                                  checkedCertificationsList = selected;
                                }),
                                onChange:
                                    (bool isChecked, String label, int index) {
                                  print(
                                      "isChecked: $isChecked   label: $label  index: $index");
                                  setState(() {
                                    certificationsCheckFlag[index] = isChecked;
                                  });
                                },
                                labels: CertificationsList,
                                checked: checkedCertificationsList,
                                itemBuilder: (Checkbox cb, Text txt, int i) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              cb,
                                              Container(
                                                // width: width*0.12,
                                                child: txt,
                                              ),
                                            ],
                                          ),
                                        ),
                                        certificationsCheckFlag[i]
                                            ? Container(
                                                width: width * 0.55,
                                                height: 50,
                                                margin: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: DateTimeField(
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      prefixIcon: Icon(
                                                          Icons.date_range),
                                                      hintText:
                                                          "Expiration date",
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.circular(10)),
                                                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10))),
                                                  format: format,
                                                  onShowPicker:
                                                      (context, currentValue) {
                                                    return showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            DateTime(1900),
                                                        initialDate:
                                                            currentValue ??
                                                                DateTime.now(),
                                                        lastDate:
                                                            DateTime(2100));
                                                  },
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),*/
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: width * 0.9,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        // margin: EdgeInsets.only(left: width*0.05, right: width*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Work Experience",
                                style: TextStyle(fontSize: 16),
                              ),
                              // margin: EdgeInsets.only(left: 10),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: jobCount,
                                itemBuilder: (context, position) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: width * 0.8,
                                          child: TextField(
                                            controller: hospitalControllerList[
                                                position],
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                prefixIcon:
                                                    Icon(Icons.local_hospital),
                                                hintText: "Hospital",
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                disabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: Colors.grey),
                                                    borderRadius: BorderRadius.circular(10))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Do you still work here?",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        /*Container(
                                          width: width * 0.6,
                                          child: RadioGroup<String>.builder(
                                            direction: Axis.horizontal,
                                            groupValue:
                                                workGroupValueList[position],
                                            onChanged: (value) => setState(() {
                                              workGroupValueList[position] =
                                                  value;
                                            }),
                                            items: workStatusList[position],
                                            itemBuilder: (item) =>
                                                RadioButtonBuilder(
                                              item,
                                            ),
                                          ),
                                        ),*/
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text("Start Date:"),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Container(
                                                  width: width * 0.8,
                                                  child: DateTimeField(
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        prefixIcon: Icon(
                                                            Icons.date_range),
                                                        hintText: "",
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        errorBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    Colors.grey),
                                                            borderRadius: BorderRadius.circular(10)),
                                                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10))),
                                                    onSaved: (val) => setState(
                                                        () => startDateList[
                                                            position] = val),
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    onChanged:
                                                        (DateTime? newValue) {
                                                      setState(() {
                                                        startDateList[
                                                                position] =
                                                            newValue;
                                                        print(startDateList[
                                                            position]);
                                                      });
                                                    },
                                                    format: format,
                                                    resetIcon: null,
                                                    onShowPicker: (context,
                                                        currentValue) {
                                                      return showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime(1900),
                                                          initialDate:
                                                              currentValue ??
                                                                  DateTime
                                                                      .now(),
                                                          lastDate:
                                                              DateTime(2100));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            workGroupValueList[position] == "No"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child:
                                                            Text("End Date:"),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Container(
                                                        width: width * 0.8,
                                                        child: DateTimeField(
                                                          decoration: InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              prefixIcon: Icon(Icons
                                                                  .date_range),
                                                              hintText: "",
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10)),
                                                              errorBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(color: Colors.grey),
                                                                  borderRadius: BorderRadius.circular(10)),
                                                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10))),
                                                          format: format,
                                                          resetIcon: null,
                                                          onSaved: (val) =>
                                                              setState(() =>
                                                                  endDateList[
                                                                          position] =
                                                                      val),
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime,
                                                          onChanged: (DateTime?
                                                              newValue) {
                                                            setState(() {
                                                              endDateList[
                                                                      position] =
                                                                  newValue;
                                                              print(endDateList[
                                                                  position]);
                                                            });
                                                          },
                                                          onShowPicker: (context,
                                                              currentValue) {
                                                            return showDatePicker(
                                                                context:
                                                                    context,
                                                                firstDate:
                                                                    DateTime(
                                                                        1900),
                                                                initialDate:
                                                                    currentValue ??
                                                                        DateTime
                                                                            .now(),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100));
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Add Job",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  jobCount++;
                                  hospitalControllerList
                                      .add(new TextEditingController());
                                  DateTime? temp;
                                  startDateList.add(temp);
                                  endDateList.add(temp);
                                  String workGroupValue = "Yes";
                                  List<String> workStatus = ["Yes", "No"];
                                  workGroupValueList.add(workGroupValue);
                                  workStatusList.add(workStatus);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                height: 50,
                margin:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                decoration: BoxDecoration(
                  color: kVolcanoMist,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onTap: () async {
                if (userNameController.text == "") {
                  alert("please input username");
                } else if (emailController.text == "") {
                  alert("please input email");
                } else if (birthdayDate == null) {
                  alert("please input birthday");
                } else if (DateTime.now().year - birthdayDate!.year < 18) {
                  alert("You must be 18+ years old to use this app.");
                } else {
                  setState(() {
                    _isInAsyncCall = true;
                  });
                  bool emptyUserName =
                      await checkUsernameIsUnique(userNameController.text);
                  bool emptyUserEmail =
                      await checkUserEmailIsUnique(emailController.text);
                  if (!emptyUserName) {
                    alert("Sorry, that user name is taken");
                  } else if (!emptyUserEmail) {
                    alert("Sorry, that user name is taken");
                  } else {
                    print("===========>" + studentGroupValue);
                    List<String> hospitalList = [];
                    List<String> startDate = [];
                    List<String> endDate = [];
                    for (int i = 0; i < hospitalControllerList.length; i++) {
                      hospitalList.add(hospitalControllerList[i].text);
                      if (startDateList[i] == null)
                        startDate.add("");
                      else
                        startDate.add(startDateList[i]!
                            .millisecondsSinceEpoch
                            .toString());
                      if (endDateList[i] == null)
                        endDate.add("");
                      else
                        endDate.add(
                            endDateList[i]!.millisecondsSinceEpoch.toString());
                    }
                    profileModel = ProfileModel(
                        userName: userNameController.text,
                        userEmail: emailController.text,
                        birthday:
                            birthdayDate!.millisecondsSinceEpoch.toString(),
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        studentFlag: studentGroupValue,
                        graduationDate: graduationDate == null
                            ? ""
                            : graduationDate!.millisecondsSinceEpoch.toString(),
                        specialty: SpecialtyDropdownValue,
                        shiftLength: ShiftLength,
                        scheduleType: ScheduleType,
                        degree: DegreeDropdownValue,
                        licenseList: checkedLicenseList,
                        certificationsList: checkedCertificationsList,
                        hospitalList: hospitalList,
                        workStatusList: workGroupValueList,
                        startDateList: startDate,
                        endDateList: endDate);
                    print(profileModel.toMap());
                    addProfile(profileModel);
                  }
                }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context)
                //   => ProfilePage(id: "SuDeeBGoQHQZSzHjCvJ2")),
                // );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
