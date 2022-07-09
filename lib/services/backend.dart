import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sbarsmartbrainapp/global.dart';
import 'package:sbarsmartbrainapp/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/patients/patient.dart';
import '../nurse.dart';

class Backend {
  static final _backend = Backend._internal();
  factory Backend() => _backend;
  Backend._internal();

  SharedPreferences? _prefs;

// get patient added by guest
  Future<Patient?> getGuestPatient() async {
    _prefs = await SharedPreferences.getInstance();
    String? tempPatient = _prefs!.getString('guestPatient');
    if (tempPatient != null) {
      Map<String, dynamic> userMap =
          jsonDecode(tempPatient) as Map<String, dynamic>;
      // mark patient as assigned to guest
      guest = true;
      guestAssigned = true;
      // map string in to patient class
      return Patient.fromMap(userMap);
    } else
      return null;
  }

// check if it's guest
  Future<bool> checkguest() async {
    _prefs = await SharedPreferences.getInstance();

    print("Guest");
    print(_prefs!.get("auth") == "guest");

    //return true if guest
    return _prefs!.get("auth") == "guest";
  }

  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  CollectionReference get patientsCollection =>
      userDocument.collection('patients');
  CollectionReference get nurseCollection => userDocument.collection('nurses');
  CollectionReference get tasksCollection => userDocument.collection('tasks');
  CollectionReference get templateCollection =>
      userDocument.collection('template');

  Stream<QuerySnapshot> get patientStream1 => patientsCollection.snapshots();
  Stream<QuerySnapshot> get nurseStream1 => nurseCollection.snapshots();
  Stream<QuerySnapshot> get taskStream1 =>
      tasksCollection.orderBy('todo_date').orderBy('todo_start').snapshots();

  Stream<List<TodoClass>> get taskStream => tasksCollection
          .orderBy('todo_date')
          .orderBy('todo_start')
          .snapshots()
          .transform<List<TodoClass>>(
        StreamTransformer.fromHandlers(
          handleData: (data, tasks) {
            tasks.add(data.docs
                .map((e) => TodoClass.fromMap(e.data() as Map<String, dynamic>))
                .toList());
          },
        ),
      );

  Stream<int> get taskCount => taskStream.transform<int>(
          StreamTransformer.fromHandlers(handleData: (list, count) {
        count.add(list.length);
      }));

  // void init() {}

  Future<void> addPatient(Patient patient) async {
    DocumentReference doc = await patientsCollection.add(patient.toMap());
    await doc.set({'id': doc.id}, SetOptions(merge: true));
  }

  Future<void> editPatient(Patient patient) async {
    await patientsCollection
        .doc(patient.id)
        .update(patient.toMap() as Map<String, Object?>);
  }

  Future<List<Patient>> getPatients() async => (await patientsCollection.get())
      .docs
      .map((e) => Patient.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  Future<void> deletePatient(Patient patient) async {
    await patientsCollection.doc(patient.id).delete();
  }

  // delete  patient added by guest
  Future<bool> deleteGuestPatient(Patient patient) async {
    _prefs = await SharedPreferences.getInstance();
    bool result = await _prefs!.remove('guestPatient');
    guestAssigned = false;
    return result;
  }

  Future<void> deleteAllPatients() async {
    List<Patient> patients = await getPatients();
    for (Patient patient in patients) await deletePatient(patient);
  }

  Future<void> addNurse(Nurse nurse) async {
    DocumentReference doc = await nurseCollection.add(nurse.toMap());
    doc.set({'id': doc.id}, SetOptions(merge: true));
  }

  Future<void> editNurse(Nurse nurse) async {
    await nurseCollection.doc(nurse.id).update(nurse.toMap());
  }

  Future<List<Nurse>> getNurses() async => (await nurseCollection.get())
      .docs
      .map((e) => Nurse.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  Future<void> deleteNurse(Nurse nurse) async {
    await nurseCollection.doc(nurse.id).delete();
  }

  Future<void> deleteAllNurses() async {
    List<Nurse> nurses = await getNurses();
    for (Nurse nurse in nurses) await deleteNurse(nurse);
  }

  Future<void> addTask(TodoClass task) async {
    DocumentReference doc = await tasksCollection.add(task.toMap());
    await doc.set({'id': doc.id}, SetOptions(merge: true));
  }

  Future<void> addTemplate(List<TodoClass> task, String? id) async {
    if (id != '') {
      await templateCollection
          .doc(id)
          .set({'id': id, 'template': task.map((e) => e.toMap()).toList()});
    } else {
      DocumentReference doc = await templateCollection
          .add({'template': task.map((e) => e.toMap()).toList()});
      await doc.set({'id': doc.id}, SetOptions(merge: true));
    }
  }

  Future<void> editTask(TodoClass task) async {
    await tasksCollection.doc(task.id).update(task.toMap());
  }

  Future<List<TodoClass>> getTasks() async => (await tasksCollection.get())
      .docs
      .map((e) => TodoClass.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  Future<List> getTemplate() async {
    var _data = (await templateCollection.get()).docs;
    return _data;
  }

  Future<void> deleteTask(TodoClass task) async {
    await tasksCollection.doc(task.id).delete();
  }

  Future<void> deleteAllTasks() async {
    List<TodoClass> tasks = await getTasks();
    for (TodoClass task in tasks) await deleteTask(task);
  }

  Future<void> completeCurTask(TodoClass task) async {
    TodoClass newTask = task;
    int _cur = int.parse(newTask.completedRepeatCount ?? '0');
    if (_cur < int.parse(newTask.repeatCount!)) {
      newTask.completedRepeatCount = (_cur + 1).toString();
    }
    await tasksCollection.doc(task.id).update(newTask.toMap());
  }

  Future<void> dispose() async {}
}
