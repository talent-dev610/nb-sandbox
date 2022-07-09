import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart'; // For calendar widget
import 'package:sbarsmartbrainapp/models/patients/patient.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:sbarsmartbrainapp/services/backend.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:universal_platform/universal_platform.dart';

import '../../global.dart';
import '../../main.dart';
import '../../models/assessments/dropdowns/task_drops.dart';
import '../../models/todo.dart';
import '../../supps/constants.dart';
import '../../supps/sbar_form_fields.dart';

class AddTask extends StatefulWidget {
  // Accept task from todo_screen
  final Patient? pt;
  AddTask({this.pt});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TodoClass tasks = TodoClass();
  final today = DateTime.now();

  //
  // formValueList to hold multiple forms
  //
  List<Map> formValueList = [
    {
      'form_key': new GlobalKey<FormState>(),
      'title_controller': new TextEditingController(),
      'description_controller': new TextEditingController(),
      'due_date_controller': new TextEditingController(),
      'due_time_controller': new TextEditingController(),
      'date_time_value': new TextEditingController(),
      'selected_category': null,
      'patient_value': null,
      'patient_id': null,
      'patient_speciality': null,
      'public_patient_value': null,
      'priority': null,
      'repeatation': null,
      'is_repeatable': false,
      'repeat_count': null,
      'reminder': Random().nextInt(1000) * Random().nextInt(1000),
      'reminder_ids': [],
      'exec_due': 0,
    },
  ];
  // error causing forms
  // List<Map> errorFormValueList = [];

  // Categories
  final TaskDropDown _taskDropDown = TaskDropDown();
  late int reminderValue;

  /// Convert Local Notifications to Firebase
  bool isReminder = false;
  var patientsBoxId;
  //
  // turn it on when form has any error
  //
  bool doesShowSnackBar = false;

  @override
  void initState() {
    super.initState();
    try {
      if (widget.pt!.nicknameField != null) {
        setState(() {
          formValueList[0]['patient_value'] =
              widget.pt!.nicknameField! + '***' + widget.pt!.id!;
          formValueList[0]['patient_id'] = widget.pt!.id;
          formValueList[0]['patient_speciality'] = widget.pt!.ptSpecialty;
          formValueList[0]['public_patient_value'] = widget.pt!.nicknameField;
        });
      }
      // formValueList[0]['repeatation'] =
      //     _taskDropDown.repeatationsList.first.value;
    } catch (e) {
      print('room num error: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenAddTask();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<QuerySnapshot>(
        stream: Backend().patientStream1,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int length = snapshot.data!.size;
            if (length > 0) {
              List<Patient> patients = snapshot.data!.docs
                  .map((e) => Patient.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              if (ptListDrop.length == 1) {
                for (int i = 0; i < length; i++) {
                  final patientsBox = patients[i];
                  if (!nicknameFields.contains(patientsBox.id)) {
                    nicknameFields.add(patientsBox.id!);
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
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: MaterialApp(
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
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
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
                            formValueList.isEmpty
                                ? FontAwesomeIcons.list
                                : formValueList[0]['selected_category'] !=
                                        'Medication'
                                    ? FontAwesomeIcons.list
                                    : FontAwesomeIcons.plus,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            formValueList.isEmpty
                                ? 'New Task'
                                : formValueList[0]['selected_category'] !=
                                        'Medication'
                                    ? 'New Task'
                                    : 'Add to MAR',
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
                            Column(
                              /// TODO Add gradient to add task screen
                              children: List.generate(
                                formValueList.length,
                                (index) {
                                  return addTaskForm(
                                      formkey: formValueList[index!]
                                          ['form_key'],
                                      category: formValueList[index!]
                                          ['selected_category'],
                                      titleTextController: formValueList[index!]
                                          ['title_controller'],
                                      descriptionController:
                                          formValueList[index!]
                                              ['description_controller'],
                                      dueDateController: formValueList[index!]
                                          ['due_date_controller'],
                                      dueDateTimeValue: formValueList[index!]
                                          ['date_time_value'],
                                      selectedPatient: formValueList[index!]
                                          ['patient_value'],
                                      priority: formValueList[index!]
                                          ['priority'],
                                      repeatation: formValueList[index!]
                                          ['repeatation'],
                                      isRepeatable: formValueList[index!]
                                          ['is_repeatable'],
                                      repeatationCount: formValueList[index!]
                                          ['repeat_count'],
                                      index: index);
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    'Add Another Task',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    //
                                    // default value form
                                    //
                                    Map<String, dynamic> newDefaultValues = {
                                      'form_key': new GlobalKey<FormState>(),
                                      'title_controller':
                                          new TextEditingController(),
                                      'description_controller':
                                          new TextEditingController(),
                                      'due_date_controller':
                                          new TextEditingController(),
                                      'due_time_controller':
                                          new TextEditingController(),
                                      'date_time_value':
                                          new TextEditingController(),
                                      'selected_category': null,
                                      'patient_value': null,
                                      'patient_id': null,
                                      'patient_speciality': null,
                                      'public_patient_value': null,
                                      'priority': null,
                                      'repeatation': null,
                                      'is_repeatable': false,
                                      'repeat_count': null,
                                      'reminder_ids': [],
                                      'reminder': Random().nextInt(1000) *
                                          Random().nextInt(1000),
                                      'exec_due': 0,
                                    };
                                    //
                                    // add default value to formValueList when new form get added
                                    //
                                    setState(() {
                                      formValueList.add(newDefaultValues);
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        _saveTaskToDb(context);
                      },
                      label: Text('Save'),
                      backgroundColor: kJadeLake,
                      icon: Icon(FontAwesomeIcons.floppyDisk),
                    ),
                  ),
                ),
              ),
            );
          } else
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                child: Center(
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(brightness: Brightness.dark),
                    child: CupertinoActivityIndicator(
                      radius: 15,
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  //
  // reusable task form
  //
  Widget addTaskForm(
      {required GlobalKey<FormState> formkey,
      required String? category,
      required TextEditingController? titleTextController,
      required TextEditingController? descriptionController,
      required TextEditingController? dueDateController,
      required TextEditingController? dueDateTimeValue,
      required dynamic selectedPatient,
      required dynamic priority,
      required dynamic repeatation,
      required bool? isRepeatable,
      required String? repeatationCount,
      required int? index}) {
    return Column(
      children: [
        Card(
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      // Category Field
                      SbarFFDrop(
                          icon: category != 'Medication'
                              ? Icons.category
                              : FontAwesomeIcons.fileMedical,
                          fieldLabel: 'Type of Task',
                          fieldValue: category,
                          onChanged: (value) {
                            setState(() {
                              formValueList[index!]['selected_category'] =
                                  value;
                              // catValue = value;
                            });
                          },
                          items: _taskDropDown.taskCatList),
                      SizedBox(height: 10.0),
                      //Title field
                      SbarFFText(
                        labelText: category != 'Medication'
                            ? 'Title'
                            : 'Medication Name',
                        hintText: category != 'Medication'
                            ? 'Title'
                            : 'Medication Name',
                        helperText: '*Required',
                        icon: category != 'Medication'
                            ? FontAwesomeIcons.noteSticky
                            : FontAwesomeIcons.filePrescription,
                        // inputFormat: [LengthLimitingTextInputFormatter(24),],
                        controller: titleTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      //Description field
                      SbarFFText(
                        labelText: category != 'Medication'
                            ? 'Description'
                            : 'Parameters / Instructions',
                        hintText: category != 'Medication'
                            ? 'Description'
                            : 'Parameters / Instructions',
                        minLines: 2,
                        icon: category != 'Medication'
                            ? FontAwesomeIcons.commentMedical
                            : FontAwesomeIcons.prescriptionBottleMedical,
                        controller: descriptionController,
                        /*validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter a description';
                                                    }
                                                    return null;
                                                  },*/
                      ),
                      SizedBox(height: 10.0),
                      //Date field
                      TextFormField(
                        onTap: () {
                          _dueDateTime(index);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a future due date & time';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Due',
                          hintText: "Due Date",
                          helperText: '*Required',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: dueDateTimeValue,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Patient Field
                      SbarFFDrop(
                          icon: FontAwesomeIcons.userInjured,
                          fieldLabel: '  Assign to Patient',
                          fieldValue: selectedPatient,
                          onChanged: (value) {
                            setState(() {
                              formValueList[index!]['patient_value'] = value;
                              formValueList[index!]['public_patient_value'] =
                                  value.split('***').first;
                              formValueList[index!]['patient_id'] =
                                  value.split('***').last;
                            });
                          },
                          items: ptListDrop),
                      SizedBox(height: 10.0),
                      // Priority Field
                      SbarFFDrop(
                          icon: FontAwesomeIcons.solidCircle,
                          fieldLabel: 'Add Priority',
                          fieldValue: priority,
                          onChanged: (value) {
                            setState(() {
                              formValueList[index!]['priority'] = value;
                            });
                          },
                          items: _taskDropDown.taskPriorityList),
                      SizedBox(height: 10),
                      // Repeat Task
                      Column(
                        children: [
                          // repeat checkbox
                          if (category != 'Medication')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: isRepeatable,
                                    onChanged: (e) {
                                      setState(() {
                                        formValueList[index!]['is_repeatable'] =
                                            !isRepeatable!;
                                      });
                                    }),
                                Text(
                                  'Repeat this Task',
                                  style: kFieldTitleStyle,
                                ),
                              ],
                            ),
                          if (isRepeatable! || category == 'Medication')
                            Column(
                              children: [
                                SizedBox(height: 10.0),
                                SbarFFDrop(
                                  icon: FontAwesomeIcons.clock,
                                  fieldLabel: 'How often?',
                                  fieldValue: repeatation,
                                  onChanged: (value) {
                                    setState(() {
                                      formValueList[index!]['repeatation'] =
                                          value;
                                    });
                                  },
                                  items: _taskDropDown.repeatationsList,
                                ),
                                SizedBox(height: 10.0),
                                SbarFFDrop(
                                  icon: FontAwesomeIcons.infinity,
                                  fieldLabel: 'How many times?',
                                  fieldValue: repeatationCount,
                                  onChanged: (value) {
                                    formValueList[index!]['reminder_ids']
                                        .clear();
                                    for (var i = 0;
                                        i <= int.parse(value);
                                        i++) {
                                      formValueList[index!]['reminder_ids'].add(
                                          Random().nextInt(1000) *
                                              Random().nextInt(1000));
                                    }
                                    setState(() {
                                      formValueList[index!]['repeat_count'] =
                                          value;
                                    });
                                  },
                                  items: _taskDropDown
                                      .repeatationCountList, // strings
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Early Reminder Field
                      /* UniversalPlatform.isWeb
                                                    ? Text(
                                                        "Please us the mobile app to receive notifications")
                                                    : Row(
                                                        children: [
                                                          Checkbox(
                                                              value: isReminder,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  isReminder =
                                                                      value;
                                                                });
                                                              }),
                                                          Text(
                                                            "Remind me before due time",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey[600],
                                                              fontSize: 18.0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                !isReminder
                                                    ? Container()
                                                    : SbarFFDrop(
                                                        icon:
                                                            FontAwesomeIcons.clock,
                                                        fieldLabel: 'How early?',
                                                        fieldValue: reminderValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            reminderValue = value;
                                                          });
                                                        },
                                                        items: _taskDropDown
                                                            .taskReminderList),*/
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
                ),
              );
            } else {
              return Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      // Category, Title
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Field
                          Expanded(
                            flex: 2,
                            child: SbarFFDrop(
                                icon: category != 'Medication'
                                    ? Icons.category
                                    : FontAwesomeIcons.fileMedical,
                                fieldLabel: 'Type of Task',
                                fieldValue: category,
                                onChanged: (value) {
                                  setState(() {
                                    formValueList[index!]['selected_category'] =
                                        value;
                                    // catValue = value;
                                  });
                                },
                                items: _taskDropDown.taskCatList),
                          ),
                          SizedBox(width: 8.0),
                          //Title field
                          Expanded(
                            flex: 3,
                            child: SbarFFText(
                              labelText: category != 'Medication'
                                  ? 'Title'
                                  : 'Medication Name',
                              hintText: category != 'Medication'
                                  ? 'Title'
                                  : 'Medication Name',
                              helperText: '*Required',
                              icon: category != 'Medication'
                                  ? FontAwesomeIcons.noteSticky
                                  : FontAwesomeIcons.filePrescription,
                              // inputFormat: [LengthLimitingTextInputFormatter(24),],
                              controller: titleTextController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a title';
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Description field
                          Expanded(
                            child: SbarFFText(
                              labelText: category != 'Medication'
                                  ? 'Description'
                                  : 'Parameters / Instructions',
                              hintText: category != 'Medication'
                                  ? 'Description'
                                  : 'Parameters / Instructions',
                              minLines: 10,
                              icon: category != 'Medication'
                                  ? FontAwesomeIcons.commentMedical
                                  : FontAwesomeIcons.prescriptionBottleMedical,
                              controller: descriptionController,
                              /*validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter a description';
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
                                    _dueDateTime(index);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a future due date & time';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Due',
                                    hintText: "Due Date",
                                    helperText: '*Required',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                  controller: dueDateTimeValue,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                // Patient Field
                                SbarFFDrop(
                                    icon: FontAwesomeIcons.userInjured,
                                    fieldLabel: '  Assign to Patient',
                                    fieldValue: selectedPatient,
                                    onChanged: (value) {
                                      setState(() {
                                        formValueList[index!]['patient_value'] =
                                            value;
                                        formValueList[index!]
                                                ['public_patient_value'] =
                                            value.split('***').first;
                                        formValueList[index!]['patient_id'] =
                                            value.split('***').last;
                                      });
                                    },
                                    items: ptListDrop),
                                SizedBox(height: 10.0),
                                // Priority Field
                                SbarFFDrop(
                                  icon: FontAwesomeIcons.solidCircle,
                                  fieldLabel: 'Add Priority',
                                  fieldValue: priority,
                                  onChanged: (value) {
                                    setState(() {
                                      formValueList[index!]['priority'] = value;
                                      // priorityValue = value;
                                    });
                                  },
                                  items: _taskDropDown.taskPriorityList,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Repeat Task
                      Column(
                        children: [
                          // Repeat checkbox
                          if (category != 'Medication')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: isRepeatable,
                                    onChanged: (e) {
                                      setState(() {
                                        formValueList[index!]['is_repeatable'] =
                                            !isRepeatable!;
                                      });
                                    }),
                                Text(
                                  'Repeat this Task',
                                  style: kFieldTitleStyle,
                                ),
                              ],
                            ),
                          if (isRepeatable! || category == 'Medication')
                            Row(
                              children: [
                                SizedBox(height: 10),
                                Expanded(
                                  child: SbarFFDrop(
                                    icon: FontAwesomeIcons.clock,
                                    fieldLabel: 'How often?',
                                    fieldValue: repeatation,
                                    onChanged: (value) {
                                      setState(() {
                                        formValueList[index!]['repeatation'] =
                                            value;
                                        // priorityValue = value;
                                      });
                                    },
                                    items: _taskDropDown.repeatationsList,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: SbarFFDrop(
                                    icon: FontAwesomeIcons.infinity,
                                    fieldLabel: 'How many times?',
                                    fieldValue: repeatationCount,
                                    onChanged: (value) {
                                      formValueList[index!]['reminder_ids']
                                          .clear();
                                      for (var i = 0;
                                          i <= int.parse(value);
                                          i++) {
                                        formValueList[index!]['reminder_ids']
                                            .add(Random().nextInt(1000) *
                                                Random().nextInt(1000));
                                      }
                                      setState(() {
                                        formValueList[index!]['repeat_count'] =
                                            value;
                                      });
                                    },
                                    items: _taskDropDown.repeatationCountList,
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),

                      // Early Reminder Field
                      /* UniversalPlatform.isWeb
                                                    ? Text(
                                                        "Please us the mobile app to receive notifications")
                                                    : Row(
                                                        children: [
                                                          Checkbox(
                                                              value: isReminder,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  isReminder =
                                                                      value;
                                                                });
                                                              }),
                                                          Text(
                                                            "Remind me before due time",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey[600],
                                                              fontSize: 18.0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                !isReminder
                                                    ? Container()
                                                    : SbarFFDrop(
                                                        icon:
                                                            FontAwesomeIcons.clock,
                                                        fieldLabel: 'How early?',
                                                        fieldValue: reminderValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            reminderValue = value;
                                                          });
                                                        },
                                                        items: _taskDropDown
                                                            .taskReminderList),*/
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
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  //
  // save task to db
  //
  _saveTaskToDb(BuildContext _context) async {
    //
    // created new list to store added task temporary
    //
    List _i = [];
    for (var form in formValueList) {
      if (form['form_key'].currentState.validate()) {
        try {
          final String title = form['title_controller'].text;
          final String desc = form['description_controller'].text;
          checkTimeSchedule();
          // make sure category != null
          if (form['selected_category'] == null) {
            form['selected_category'] = 'General';
          }
          if (form['selected_category'] == 'Medication') {
            form['is_repeatable'] = true;
          }
          if (form['priority'] == null) {
            form['priority'] = 'Medium';
          }

          if (form['public_patient_value'] == null ||
              form['public_patient_value'].toString().length == 0) {
            form['public_patient_value'] = 'None';
          }
          if (form['is_early_reminder'] && form['early_count'] == null) {
            form['early_count'] = 30;
          }

          tasks = TodoClass(
            todoTitle: title.trim(),
            todoDesc: desc.trim(),
            todoDate: form['due_date_controller'].text.trim(),
            todoStart: form['due_time_controller'].text.trim(),
            todoPt: form['patient_value'],
            ptId: form['patient_id'],
            publicPtValue: form['public_patient_value'] ?? 'None',
            specialty: form['patient_speciality'],
            todoCat: form['selected_category'],
            todoRank: form['priority'],
            isRepeatable: form['is_repeatable'],
            completedRepeatCount: '0',
            repeatationFrequency: form['repeatation'],
            repeatCount: form['repeat_count'] ?? '1',
            isCompleted: false,
            reminderId: form['reminder'],
            dateCreated: DateTime.now().millisecondsSinceEpoch,
            isReminder: isReminder,
            reminderTime: reminderValue,
            exactDue: form['exec_due'],
            reminderIds: form['reminder_ids'],
          );
          await Backend().addTask(tasks);
          bool onTime =
              DateTime.now().millisecondsSinceEpoch > form['exec_due'];
          await CustomAnalytics().eventAddTask(
              form['selected_category'],
              form['priority'],
              form['patient_id'],
              form['patient_speciality'],
              onTime);

          /// Add early reminder
          /*if (isReminder && !UniversalPlatform.isWeb) {
                            setReminderNotification(
                                tasks.reminderId, title.trim(), desc.trim());
                          }*/
          if (!UniversalPlatform.isWeb) {
            if (form['repeatation'] != null) {
              for (var i = 0; i < int.parse(form['repeat_count']); i++) {
                DateTime _selectedDT = i <= 0
                    ? selectDate
                    : selectDate.add(
                        Duration(
                            minutes:
                                int.parse(formValueList[0]['repeatation']) * i),
                      );
                await defaultReminderNotification(
                    i <= 0 ? form['reminder'] : form['reminder_ids'][i],
                    title.trim(),
                    form['public_patient_value'] ?? 'None',
                    desc.trim(),
                    _selectedDT);
              }
            } else {
              await defaultReminderNotification(
                  form['reminder'],
                  title.trim(),
                  form['public_patient_value'] ?? 'None',
                  desc.trim(),
                  selectDate);
            }
            //
            // add task to temporary list if status is success
            //
            setState(() {
              _i.add(form);
            });
          }
        } catch (e) {}
      } else {
        CustomAnalytics().eventAttemptAddTask(form['selected_category'],
            form['priority'], form['patient_id'], widget.pt?.ptSpecialty ?? '');
        setState(() {
          doesShowSnackBar = true;
        });
      }
    }
    //
    // remove all success task form main formValueList which is stored in temporary list
    //
    setState(() {
      for (var j in _i) {
        formValueList.remove(j);
      }
    });

    //
    // show on sucess
    //
    // ScaffoldMessenger.of(_context).showSnackBar(
    //   SnackBar(
    //     duration: kMediumSnack,
    //     backgroundColor: kMidNightSkyBlend,
    //     content: Text(
    //       'Task added!',
    //       style: TextStyle(
    //         fontSize: 16.0,
    //       ),
    //     ),
    //   ),
    // );
    //
    // show while error
    //
    if (doesShowSnackBar) {
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
    if (formValueList.isEmpty) {
      currentIndex = 2;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  var _startTime;
  var _dueDate;
  late DateTime selectDate;
  // int exactDue;

  _dueDateTime(index) async {
    DateTime _date = DateTime.now();
    final selectedDate = await showDatePicker(
      initialDate: _date,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(today.year + 1, today.month, today.day),
    );
    final selectedTime = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute),
    );

    if (selectedDate != null && selectedDate != _date && selectedTime != null) {
      setState(() {
        //
        // created datetime object from picked date and time
        //
        selectDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
            selectedDate.second);

        // convert due date and time to integer
        // execdue = selectDate.millisecondsSinceEpoch;
        formValueList[index!]['exec_due'] = selectDate.millisecondsSinceEpoch;
        /* convert dateTime to int then convert int from server to app as dateTime
        print('Convert due date from int back to dateTime is ${DateTime.fromMillisecondsSinceEpoch(exactDue)}');
        */

        if (DateTime.fromMillisecondsSinceEpoch(
                DateTime.now().millisecondsSinceEpoch)
            .isBefore(DateTime.fromMillisecondsSinceEpoch(
                selectDate.millisecondsSinceEpoch))) {
          _dueDate = DateFormat('MM/dd/yyyy').format(selectedDate).toString();
          _startTime =
              MaterialLocalizations.of(context).formatTimeOfDay(selectedTime);
          formValueList[index!]['due_date_controller'].text = _dueDate;
          // + ' at ' + _startTime;
          formValueList[index!]['date_time_value'].text =
              _dueDate + ' at ' + _startTime;

          formValueList[index!]['due_time_controller'].text = _startTime;
        }
        formValueList[index!]['form_key'].currentState.validate();
      });
    }
  }

  defaultReminderNotification(int id, String title, String patient,
      String description, DateTime selectedDateTime) async {
    tz.initializeTimeZones();
    var defaultNotificationDateTime =
        tz.TZDateTime.from(selectedDateTime, tz.local)
            .add(Duration(minutes: -0));
    var android = AndroidNotificationDetails('channelId', 'channelDescription',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        // Modify notification title, description
        id,
        'Due Now: $title - Patient: $patient',
        '$description',
        defaultNotificationDateTime,
        platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

// custom reminder time
  /*setReminderNotification(int id, String title, String description) async {
    tz.initializeTimeZones();
    print(selectDate);
    var scheduledNotificationDateTime1 = tz.TZDateTime.from(selectDate, tz.local).add(Duration(minutes: -reminderValue));
    var android = AndroidNotificationDetails('id', 'channel ', 'description', priority: Priority.high, importance: Importance.max);
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
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }*/

  checkTimeSchedule() {
    Duration dur = DateTime.now().difference(selectDate);
  }
}
