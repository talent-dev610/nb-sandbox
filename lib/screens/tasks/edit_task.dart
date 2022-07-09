import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:universal_platform/universal_platform.dart';

import '../../global.dart';
import '../../main.dart';
import '../../models/assessments/dropdowns/task_drops.dart';
import '../../models/patients/patient.dart';
import '../../models/todo.dart';
import '../../services/backend.dart';
import '../../supps/constants.dart';
import '../../supps/sbar_form_fields.dart';

class EditTask extends StatefulWidget {
// Accept task from todo_screen
  final TodoClass? todo;
  EditTask({this.todo});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TodoClass tasks = TodoClass();
  final _taskFormKey = GlobalKey<FormState>();
  final today = DateTime.now();
  List newReminderIds = [];
  // Categories
  final TaskDropDown _taskDropDown = TaskDropDown();
  var catValue; // Category form field value
  var priorityValue;
  int? reminderValue;
  bool? isReminder = false;
  //
  // turn it on when form has any error
  //
  bool doesShowSnackBar = false;

  // Patient list
  Widget? ptDropDown;
  var ptValue; // Patient form field value
  var ptId;
  var publicPtValue;
  var specialty;
  var medicalDx;
  List<DropdownMenuItem<String>> ptListDrop = [
    // Initial value
    DropdownMenuItem<String>(
      value: 'None',
      child: Text(
        'None',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 20.0,
        ),
      ),
    ),
  ];

  List<String> nicknameFields = [];

  // variables for obtaining form field values on validation
  var titleText;
  var descText;
  var dueText;
  var _prevDueDate;
  var _startTime;
  var _dueDate;
  late DateTime selectDate;
  int? exactDue;

  bool? isRepeatable;
  dynamic repeatationCount;
  dynamic repeatationFrequency;
  String? completedRepeatCountValue;

  @override

  // Obtaining special form field values from previous screen
  void initState() {
    super.initState();
    // set date and time form field initial value
    // & prompt user to enter new due date
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      newReminderIds.clear();
      for (var i = 0; i <= int.parse(repeatationCount); i++) {
        newReminderIds.add(Random().nextInt(1000) * Random().nextInt(1000));
      }
    });
    _prevDueDate = (widget.todo!.exactDue != null && widget.todo!.exactDue != 0)
        ? TextEditingController.fromValue(
            TextEditingValue(
              text: (widget.todo!.todoDate.toString() +
                  ' at ' +
                  widget.todo!.todoStart.toString()),
            ),
          )
        : TextEditingController.fromValue(
            TextEditingValue(text: 'Re-enter Due Time'));
    // set category form field initial value
    /*
     Note: if ptValue is initialized with 'None',
     it can some times cause null errors
     */
    // todo fix edit task -> ptValue logic
    ptValue = widget.todo!.todoPt != 'None' ? widget.todo!.todoPt : 'None';
    ptId = widget.todo!.ptId;
    publicPtValue = widget.todo!.publicPtValue;
    specialty = widget.todo!.specialty;
    catValue = widget.todo!.todoCat;
    priorityValue = widget.todo!.todoRank;
    isReminder = widget.todo!.isReminder;
    reminderValue =
        widget.todo!.reminderTime == 0 ? null : widget.todo!.reminderTime;
    exactDue = widget.todo!.exactDue != null ? widget.todo!.exactDue : 0;
    descText = widget.todo!.todoDesc;
    selectDate = DateTime.fromMicrosecondsSinceEpoch(
        widget.todo!.exactDue != null ? widget.todo!.exactDue! : 0);
    isRepeatable = widget.todo!.isRepeatable ?? false;
    repeatationCount = widget.todo!.repeatCount.toString();
    repeatationFrequency = widget.todo!.repeatationFrequency;
    completedRepeatCountValue = widget.todo!.completedRepeatCount ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenUpdateTask();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
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
                            currentIndex = 2;
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
                  currentIndex = 2;
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(),
                Icon(
                  FontAwesomeIcons.list,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  catValue != 'Medication' ? 'Task Editor' : 'Add to MAR',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: [
                          Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 768) {
                                  return Form(
                                      key: _taskFormKey,
                                      child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(height: 8.0),
                                                // Category Field
                                                SbarFFDrop(
                                                    icon:
                                                        catValue != 'Medication'
                                                            ? Icons.category
                                                            : FontAwesomeIcons
                                                                .fileMedical,
                                                    fieldLabel: 'Type of Task',
                                                    fieldValue: catValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        catValue = value;
                                                      });
                                                    },
                                                    items: _taskDropDown
                                                        .taskCatList),
                                                SizedBox(height: 10.0),
                                                // Title field
                                                SbarFFText(
                                                  initialValue:
                                                      widget.todo!.todoTitle,
                                                  labelText:
                                                      catValue != 'Medication'
                                                          ? 'Title'
                                                          : 'Medication Name',
                                                  hintText:
                                                      catValue != 'Medication'
                                                          ? 'Title'
                                                          : 'Medication Name',
                                                  helperText: '*Required',
                                                  icon: catValue != 'Medication'
                                                      ? FontAwesomeIcons
                                                          .noteSticky
                                                      : FontAwesomeIcons
                                                          .filePrescription,
                                                  // inputFormat: [LengthLimitingTextInputFormatter(24),],
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter a title';
                                                    } else {
                                                      titleText = value;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 10.0),
                                                // Description field
                                                SbarFFText(
                                                  initialValue:
                                                      widget.todo!.todoDesc,
                                                  labelText: catValue !=
                                                          'Medication'
                                                      ? 'Description'
                                                      : 'Parameters / Instructions',
                                                  hintText: catValue !=
                                                          'Medication'
                                                      ? 'Description'
                                                      : 'Parameters / Instructions',
                                                  minLines: 2,
                                                  icon: catValue != 'Medication'
                                                      ? FontAwesomeIcons
                                                          .commentMedical
                                                      : FontAwesomeIcons
                                                          .prescriptionBottleMedical,
                                                  onChanged: (value) {
                                                    descText = value;
                                                  },
                                                  // inputFormat: [LengthLimitingTextInputFormatter(48),],
                                                  /*validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter a description';
                                                  } else {
                                                    descText = value;
                                                  }
                                                  return null;
                                                },*/
                                                ),
                                                SizedBox(height: 10.0),
                                                // Date field
                                                TextFormField(
                                                  onTap: () {
                                                    _dueDateTime();
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty ||
                                                        value.contains(
                                                            'enter')) {
                                                      return 'Please enter a future due date and time';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Due',
                                                    hintText: "Due Date",
                                                    helperText: '*Required',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    prefixIcon: Icon(
                                                        Icons.calendar_today),
                                                  ),
                                                  controller: _prevDueDate,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),
                                                // Patient Field
                                                patientDropBox(),
                                                SizedBox(height: 10.0),
                                                // Priority Field
                                                SbarFFDrop(
                                                    icon: FontAwesomeIcons
                                                        .solidCircle,
                                                    fieldLabel: 'Add Priority',
                                                    fieldValue: priorityValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        priorityValue = value;
                                                      });
                                                    },
                                                    items: _taskDropDown
                                                        .taskPriorityList),
                                                SizedBox(height: 10),
                                                // Repeat Task
                                                Column(children: [
                                                  // repeat checkbox
                                                  if (catValue != 'Medication')
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Checkbox(
                                                            value: isRepeatable,
                                                            onChanged: (e) {
                                                              setState(() {
                                                                isRepeatable =
                                                                    !isRepeatable!;
                                                              });
                                                            }),
                                                        Text(
                                                          'Repeat this Task',
                                                          style:
                                                              kFieldTitleStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  if (isRepeatable! ||
                                                      catValue == 'Medication')
                                                    Column(
                                                      children: [
                                                        SizedBox(height: 10.0),
                                                        SbarFFDrop(
                                                          icon: FontAwesomeIcons
                                                              .clock,
                                                          fieldLabel:
                                                              'How often?',
                                                          fieldValue:
                                                              repeatationFrequency ??
                                                                  _taskDropDown
                                                                      .repeatationsList
                                                                      .first
                                                                      .value,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              repeatationFrequency =
                                                                  value;
                                                            });
                                                          },
                                                          items: _taskDropDown
                                                              .repeatationsList,
                                                        ),
                                                        SizedBox(height: 10.0),
                                                        SbarFFDrop(
                                                            icon:
                                                                FontAwesomeIcons
                                                                    .infinity,
                                                            fieldLabel:
                                                                'How many times?',
                                                            fieldValue:
                                                                repeatationCount ??
                                                                    _taskDropDown
                                                                        .repeatationCountList
                                                                        .first
                                                                        .value,
                                                            onChanged: (value) {
                                                              newReminderIds
                                                                  .clear();
                                                              for (var i = 0;
                                                                  i <=
                                                                      int.parse(
                                                                          value);
                                                                  i++) {
                                                                newReminderIds.add(Random()
                                                                        .nextInt(
                                                                            1000) *
                                                                    Random()
                                                                        .nextInt(
                                                                            1000));
                                                              }
                                                              setState(() {
                                                                repeatationCount =
                                                                    value;
                                                                // priorityValue = value;
                                                              });
                                                            },
                                                            items: _taskDropDown
                                                                .repeatationCountList),
                                                        SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        // Text('Patient'),
                                                        // Text('Description'),
                                                        // Text('Date'),
                                                        // Text('Start'),
                                                        // Text('Complete'),
                                                        // Text('Frequency'),
                                                        // Text('Priority'),
                                                        // Text('Category'),
                                                        // Text('List'),
                                                        // Text('Tags'),
                                                      ],
                                                    ),
                                                ]),
                                              ])));
                                } else {
                                  return Form(
                                    key: _taskFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(height: 10.0),
                                          //Category, Title
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Category
                                              Expanded(
                                                flex: 2,
                                                child: SbarFFDrop(
                                                    icon:
                                                        catValue != 'Medication'
                                                            ? Icons.category
                                                            : FontAwesomeIcons
                                                                .fileMedical,
                                                    fieldLabel: 'Type of Task',
                                                    fieldValue: catValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        catValue = value;
                                                      });
                                                    },
                                                    items: _taskDropDown
                                                        .taskCatList),
                                              ),
                                              SizedBox(width: 8.0),
                                              // Title
                                              Expanded(
                                                flex: 3,
                                                child: SbarFFText(
                                                  initialValue:
                                                      widget.todo!.todoTitle,
                                                  labelText:
                                                      catValue != 'Medication'
                                                          ? 'Title'
                                                          : 'Medication Name',
                                                  hintText:
                                                      catValue != 'Medication'
                                                          ? 'Title'
                                                          : 'Medication Name',
                                                  helperText: '*Required',
                                                  icon: catValue != 'Medication'
                                                      ? FontAwesomeIcons
                                                          .noteSticky
                                                      : FontAwesomeIcons
                                                          .filePrescription,
                                                  // inputFormat: [LengthLimitingTextInputFormatter(24),],
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter a title';
                                                    } else {
                                                      titleText = value;
                                                    }
                                                    return null;
                                                  },
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          // Description, Date, Patient, Priority
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Description
                                              Expanded(
                                                child: SbarFFText(
                                                  initialValue:
                                                      widget.todo!.todoDesc,
                                                  labelText: catValue !=
                                                          'Medication'
                                                      ? 'Description'
                                                      : 'Parameters / Instructions',
                                                  hintText: catValue !=
                                                          'Medication'
                                                      ? 'Description'
                                                      : 'Parameters / Instructions',
                                                  minLines: 10,
                                                  icon: catValue != 'Medication'
                                                      ? FontAwesomeIcons
                                                          .commentMedical
                                                      : FontAwesomeIcons
                                                          .prescriptionBottleMedical,
                                                  // inputFormat: [LengthLimitingTextInputFormatter(48),],
                                                  /*validator: (value) {
                                                            if (value.isEmpty) {
                                                              return 'Please enter a description';
                                                            } else {
                                                              descText = value;
                                                            }
                                                            return null;
                                                          },*/
                                                ),
                                              ),
                                              SizedBox(width: 8.0),
                                              // Date, Patient, Priority
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    // Date field
                                                    TextFormField(
                                                      onTap: () {
                                                        //
                                                        // pick date and time
                                                        //
                                                        _dueDateTime();
                                                      },
                                                      validator: (value) {
                                                        if (value!.isEmpty ||
                                                            value.contains(
                                                                'enter')) {
                                                          return 'Please enter a future due date & time';
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Due',
                                                        hintText: "Due Date",
                                                        helperText: '*Required',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        prefixIcon: Icon(Icons
                                                            .calendar_today),
                                                      ),
                                                      controller: _prevDueDate,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    // Patient Field
                                                    patientDropBox(),
                                                    SizedBox(height: 10.0),
                                                    SbarFFDrop(
                                                        icon: FontAwesomeIcons
                                                            .solidCircle,
                                                        fieldLabel:
                                                            'Add Priority',
                                                        fieldValue:
                                                            priorityValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            priorityValue =
                                                                value;
                                                          });
                                                        },
                                                        items: _taskDropDown
                                                            .taskPriorityList),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          // Repeat Task
                                          Column(
                                            children: [
                                              // Repeat checkbox
                                              if (catValue != 'Medication')
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Checkbox(
                                                        value: isRepeatable,
                                                        onChanged: (e) {
                                                          setState(() {
                                                            isRepeatable =
                                                                !isRepeatable!;
                                                          });
                                                        }),
                                                    Text(
                                                      'Repeat this Task',
                                                      style: kFieldTitleStyle,
                                                    ),
                                                  ],
                                                ),
                                              if (isRepeatable! ||
                                                  catValue == 'Medication')
                                                Row(children: [
                                                  Expanded(
                                                    child: SbarFFDrop(
                                                        icon: FontAwesomeIcons
                                                            .clock,
                                                        fieldLabel:
                                                            'How often?',
                                                        fieldValue:
                                                            repeatationFrequency ??
                                                                _taskDropDown
                                                                    .repeatationsList
                                                                    .first
                                                                    .value,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            repeatationFrequency =
                                                                value;
                                                            // priorityValue = value;
                                                          });
                                                        },
                                                        items: _taskDropDown
                                                            .repeatationsList),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  Expanded(
                                                    child: SbarFFDrop(
                                                        icon: FontAwesomeIcons
                                                            .infinity,
                                                        fieldLabel:
                                                            'How many times?',
                                                        fieldValue:
                                                            repeatationCount ??
                                                                _taskDropDown
                                                                    .repeatationCountList
                                                                    .first
                                                                    .value,
                                                        onChanged: (value) {
                                                          newReminderIds
                                                              .clear();
                                                          for (var i = 0;
                                                              i <=
                                                                  int.parse(
                                                                      value);
                                                              i++) {
                                                            newReminderIds.add(
                                                                Random().nextInt(
                                                                        1000) *
                                                                    Random()
                                                                        .nextInt(
                                                                            1000));
                                                          }
                                                          setState(() {
                                                            repeatationCount =
                                                                value;
                                                            // priorityValue = value;
                                                          });
                                                        },
                                                        items: _taskDropDown
                                                            .repeatationCountList),
                                                  ),
                                                ]),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          )
                                          // Text('Patient'),
                                          // Text('Description'),
                                          // Text('Date'),
                                          // Text('Start'),
                                          // Text('Complete'),
                                          // Text('Frequency'),
                                          // Text('Priority'),
                                          // Text('Category'),
                                          // Text('List'),
                                          // Text('Tags'),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _saveTaskToDb();
            },
            label: Text('Save'),
            backgroundColor: kJadeLake,
            icon: Icon(FontAwesomeIcons.floppyDisk),
          ),
        ),
      ),
    );
  }

  Widget patientDropBox() {
    return StreamBuilder<QuerySnapshot>(
        stream: Backend().patientStream1,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int length = snapshot.data!.size;
            if (length > 0) {
              List<Patient> patients = snapshot.data!.docs
                  .map((e) => Patient.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              // loop to add patients to dropdown list
              if (ptListDrop.length == 1) {
                for (int i = 0; i < length; i++) {
                  final patientsBox = patients[i];
                  if (!nicknameFields.contains(
                      patientsBox.nicknameField! + '***' + patientsBox.id!)) {
                    nicknameFields.add(
                        patientsBox.nicknameField! + '***' + patientsBox.id!);
                    ptListDrop.add(
                      DropdownMenuItem<String>(
                        value: patientsBox.nicknameField! +
                            '***' +
                            patientsBox.id!,
                        child: Text(
                          patientsBox.nicknameField!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    );
                  }
                }
              }
            }
          }
          // make sure that dropdown menu doesn't contain any outdated items which lead to null errors
          bool currentPtList = nicknameFields.contains(ptValue);
          return SbarFFDrop(
              icon: FontAwesomeIcons.userInjured,
              fieldLabel: 'Assign to Patient',
              fieldValue: ptValue != null && ptValue.isNotEmpty && currentPtList
                  ? ptValue
                  : 'None',
              onChanged: (value) {
                setState(() {
                  ptValue = value;
                  var splitted = value.split('***');
                  publicPtValue = splitted.first;
                  ptId = splitted.last;
                  print('ptId is: $ptId');
                });
              },
              items: ptListDrop);
        });
  }

  //
  // save task to db
  //
  _saveTaskToDb() async {
    // make sure date and field are not null
    if (_taskFormKey.currentState!.validate()) {
      if (_dueDate == null && _startTime == null) {
        _dueDate = widget.todo!.todoDate;
        _startTime = widget.todo!.todoStart;
      }
      if (ptValue == null || ptValue == '') {
        ptValue = 'None';
      }
      if (catValue == 'Medication') {
        isRepeatable = true;
      }
      if (isReminder! && reminderValue == null) {
        reminderValue = 15;
      }
      tasks = TodoClass(
          id: widget.todo!.id,
          ptId: ptId,
          publicPtValue: publicPtValue,
          todoTitle: titleText,
          todoDesc: descText,
          todoDate: _dueDate.toString(),
          todoStart: _startTime.toString(),
          dateCreated: widget.todo!.dateCreated,
          dateUpdated: DateTime.now().millisecondsSinceEpoch,
          todoPt: ptValue,
          todoCat: catValue,
          todoRank: priorityValue,
          isRepeatable: isRepeatable,
          repeatationFrequency: repeatationFrequency,
          completedRepeatCount: completedRepeatCountValue ?? '0',
          repeatCount: repeatationCount ?? '0',
          isCompleted: false,
          reminderId: widget.todo!.reminderId,
          reminderIds: newReminderIds,
          isReminder: isReminder,
          reminderTime: reminderValue,
          exactDue: exactDue);
      await Backend().editTask(tasks);
      bool onTime = today.millisecondsSinceEpoch > exactDue!;
      CustomAnalytics()
          .eventUpdateTask(catValue, priorityValue, ptId, specialty, onTime);
      if (!UniversalPlatform.isWeb) {
        try {
          // cancel pending notifications
          if (widget.todo!.reminderId != null) {
            await flutterLocalNotificationsPlugin.cancel(tasks.reminderId!);
            if (widget.todo!.earlyReminderId != null) {
              await flutterLocalNotificationsPlugin
                  .cancel(tasks.earlyReminderId!);
            }
            if (widget.todo!.reminderIds!.isNotEmpty) {
              for (var k in widget.todo!.reminderIds!) {
                await flutterLocalNotificationsPlugin.cancel(k);
              }
            }
          }
          for (var i = 0; i < int.parse(repeatationCount); i++) {
            DateTime _selectedDT = i <= 0
                ? selectDate
                : selectDate.add(
                    Duration(minutes: int.parse(repeatationFrequency) * i),
                  );
            await defaultReminderNotification(
                i <= 0 ? widget.todo!.reminderId : newReminderIds[i],
                titleText,
                descText,
                _selectedDT);
          }
          // defaultReminderNotification(
          //     tasks.reminderId, titleText, descText, exactDue);
        } catch (e) {}
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        doesShowSnackBar = true;
      });
      if (doesShowSnackBar) {
        CustomAnalytics()
            .eventAttemptUpdateTask(catValue, priorityValue, ptId, specialty);
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
  }

  _dueDateTime() async {
    DateTime _date = DateTime.now();
    final selectedDate = await (showDatePicker(
      initialDate: _date,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(today.year + 1, today.month, today.day),
    ));

    final selectedTime = await (showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ));
    //
    // created datetime object from picked date and time
    //
    var _selectDate = DateTime(
        selectedDate!.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime!.hour,
        selectedTime.minute,
        selectedDate.second);
    if (DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
        .isBefore(DateTime.fromMillisecondsSinceEpoch(
            _selectDate.millisecondsSinceEpoch))) {
      // validate date and time values
      if (selectedDate != _date) {
        setState(() {
          selectDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
              selectedDate.second);

          // convert due date and time to integer
          exactDue = selectDate.millisecondsSinceEpoch;

          _dueDate = DateFormat('MM/dd/yyyy').format(selectedDate).toString();
          _startTime =
              MaterialLocalizations.of(context).formatTimeOfDay(selectedTime);

          _prevDueDate.text = _dueDate + ' at ' + _startTime;
        });
      }
    }
  }

  defaultReminderNotification(int id, String title, String description,
      DateTime selectedDateTime) async {
    try {
      tz.initializeTimeZones();
      var defaultNotificationDateTime =
          tz.TZDateTime.from(selectedDateTime, tz.local)
              .add(Duration(minutes: -0));
      var android = AndroidNotificationDetails(
          'channelId', 'channelDescription',
          priority: Priority.high, importance: Importance.max);
      var iOS = IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: iOS);

      await flutterLocalNotificationsPlugin.zonedSchedule(
          // Modify notification title, description
          id,
          'Due Now: $title - Patient: $ptValue',
          '$description',
          defaultNotificationDateTime,
          platform,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {}
  }

// custom reminder time
/* setReminderNotification(int id, String title, String description) async {
    tz.initializeTimeZones();
    print(selectDate);
    var scheduledNotificationDateTime1 =
        tz.TZDateTime.from(selectDate, tz.local)
            .add(Duration(minutes: -reminderValue));
    var scheduledNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        // Modify notification title, description
        id,
        'Due Soon: $title - Patient: $ptValue',
        '$description',
        scheduledNotificationDateTime1,
        platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
*/
}
