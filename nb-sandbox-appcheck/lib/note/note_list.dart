import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sbarsmartbrainapp/global.dart';
import 'package:sbarsmartbrainapp/models/NoteModel.dart';
import 'package:sbarsmartbrainapp/models/ProfileModel.dart';
// import 'package:sbarsmartbrainapp/models/NoteModel.dart';
import 'package:sbarsmartbrainapp/note/edit_note.dart';
import 'package:sbarsmartbrainapp/note/note.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

// import '../models/ProfileModel.dart';

class NoteListPage extends StatefulWidget {
  @override
  NoteListPageState createState() => NoteListPageState();
}

class NoteListPageState extends State<NoteListPage> {
  final format = DateFormat("yyyy-MM-dd");
  bool _isInAsyncCall = true;
  List<NoteModel> noteModelList = [];

  DocumentReference get userDocument => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  CollectionReference get noteCollection => userDocument.collection('notes');

  Future<ProfileModel>? getData() {
    noteCollection.get().then((value) {
      print(value.docs.length);
      setState(() {
        for (int i = 0; i < value.docs.length; i++) {
          noteModelList.add(NoteModel.fromMap(Map<String, dynamic>.from(
              value.docs[i].data() as Map<dynamic, dynamic>)));
        }
        _isInAsyncCall = false;
      });
    });
    return null;
  }

  Future<void> deleteNote(NoteModel noteModel) async {
    noteCollection.doc(noteModel.id).delete().then((value) {
      setState(() {
        noteModelList.clear();
        getData();
        _isInAsyncCall = false;
      });
      //
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialIndex = 1;
    CustomAnalytics().screenNotesList();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.greenAccent])),
          child: noteModelList.length == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      child: Card(
                        // color: Colors.orangeAccent[100],
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.noteSticky,
                              color: kVolcanoMist,
                            ),
                            onPressed: () {},
                          ),
                          title: Text(
                            'Write your first note!',
                            style: TextStyle(
                              fontSize: 20,
                              // color: kMidNightSkyBlend,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Tap here to get started.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditNotePage(
                                    newEditFlag: true,
                                  )),
                        );
                      },
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: noteModelList.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          Slidable(
                            startActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.solidPenToSquare,
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditNotePage(
                                                id: noteModelList[position].id,
                                                newEditFlag: false,
                                              )),
                                    );
                                  },
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  onPressed: (context) {
                                    setState(() {
                                      _isInAsyncCall = true;
                                      deleteNote(noteModelList[position]);
                                    });
                                    CustomAnalytics().eventDeleteNote();
                                  },
                                ),
                              ],
                            ),
                            child: Container(
                              color: Colors.white,
                              width: width,
                              padding: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    noteModelList[position].title!.length > 20
                                        ? noteModelList[position]
                                                .title!
                                                .substring(0, 20) +
                                            "..."
                                        : noteModelList[position].title!,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      noteModelList[position].body!.length > 30
                                          ? noteModelList[position]
                                                  .body!
                                                  .substring(0, 30) +
                                              "..."
                                          : noteModelList[position].body!,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          DateFormat('M/d/y')
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      int.parse(noteModelList[
                                                              position]
                                                          .last_date!)))
                                              .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          noteModelList[position].category!,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        print(noteModelList[position].id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotePage(
                                    noteModel: noteModelList[position],
                                  )),
                        );
                      },
                      onDoubleTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditNotePage(
                                    id: noteModelList[position].id,
                                    newEditFlag: false,
                                  )),
                        );
                      },
                    );
                  })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          FontAwesomeIcons.plus,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNotePage(
                      newEditFlag: true,
                    )),
          );
        },
      ),
    );
  }
}
