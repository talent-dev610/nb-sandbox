import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sbarsmartbrainapp/models/NoteModel.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';

import '../global.dart';
import '../screens/home/home.dart';

class EditNotePage extends StatefulWidget {
  String? id;
  bool? newEditFlag;
  EditNotePage({
    this.id,
    this.newEditFlag,
  });
  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  final format = DateFormat("yyyy-MM-dd");
  bool _isInAsyncCall = true;

  TextEditingController titleController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();

  String? categoryDropdownValue = 'General';
  List<String> categories = [
    'General',
    'Contacts',
    'Medical',
    'Procedures',
  ];

  NoteModel noteModel = NoteModel();

  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  CollectionReference get noteCollection => userDocument.collection('notes');

  Future<void> editNote(NoteModel noteModel) async {
    noteCollection.doc(widget.id).update(noteModel.toMap()).then((value) {
      setState(() {
        _isInAsyncCall = false;
      });
      // tapIndex = 2;
      currentIndex = 3;
      initialIndex = 1;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  Future<void> addNote(NoteModel noteModel) async {
    DocumentReference doc = await noteCollection.add(noteModel.toMap());
    doc.set({'id': doc.id}, SetOptions(merge: true)).then((value) {
      setState(() {
        print("+++++++++++++");
        print(doc.id);
        print(FirebaseAuth.instance.currentUser!.uid);
        // tapIndex = 2;
        currentIndex = 3;
        initialIndex = 1;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        _isInAsyncCall = false;
      });
    });
  }

  Future<NoteModel?> getData(String? id) async {
    if (id != null) {
      noteCollection.doc(id).get().then((DocumentSnapshot doc) {
        setState(() {
          noteModel = NoteModel.fromMap(
              Map<String, dynamic>.from(doc.data() as Map<dynamic, dynamic>));
          titleController.text = noteModel.title!;
          categoryDropdownValue = noteModel.category;
          categoryController.text = noteModel.body!;
          _isInAsyncCall = false;
        });
      });
    } else {
      setState(() {
        _isInAsyncCall = false;
      });
    }
    return null;
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenUpdateNote();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        // color: Colors.black.withOpacity(0.85),
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
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                GestureDetector(
                  child: Container(
                    width: width * 0.13,
                    height: width * 0.13,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white.withOpacity(0.7)),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
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
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              int _popScreens = 0;
                              Navigator.of(context)
                                  .popUntil((_) => _popScreens++ >= 2);
                            },
                          ),
                          TextButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                            child: Text(
                              'Keep Open',
                              style: TextStyle(color: Colors.white),
                            ),
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
                    int _popScreens = 0;
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: width * 0.45,
                ),
                GestureDetector(
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.13,
                    alignment: Alignment.center,
                    // padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white.withOpacity(0.7)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    if (titleController.text == "") {
                      alert("please input title");
                    } else {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _isInAsyncCall = true;
                      });
                      if (widget.newEditFlag!) {
                        noteModel = NoteModel(
                          title: titleController.text,
                          category: categoryDropdownValue,
                          body: categoryController.text,
                          created_date:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          last_date:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        );
                        addNote(noteModel);
                        // CustomAnalytics().eventAddNote();
                      } else {
                        print(widget.id);
                        noteModel = NoteModel(
                          id: widget.id,
                          title: titleController.text,
                          category: categoryDropdownValue,
                          body: categoryController.text,
                          created_date: noteModel.created_date,
                          last_date:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        );
                        editNote(noteModel);
                        // CustomAnalytics().eventUpdateNote();
                      }
                    }
                  },
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: TextField(
                    controller: titleController,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: null,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        hintText: "Title",
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(top: 7, bottom: 7, left: 10),
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white.withOpacity(0.7)),
                  child: Row(
                    children: [
                      DropdownButton<String>(
                        value: categoryDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 0,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryDropdownValue = newValue;
                          });
                        },
                        items: categories.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: TextField(
                    controller: categoryController,
                    maxLines: 10,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7), fontSize: 20),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        hintText: "Type something...",
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
