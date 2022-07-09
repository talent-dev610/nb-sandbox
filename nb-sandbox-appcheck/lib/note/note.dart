import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sbarsmartbrainapp/models/NoteModel.dart';
import 'package:sbarsmartbrainapp/note/edit_note.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';

class NotePage extends StatefulWidget {
  NoteModel? noteModel;
  NotePage({
    this.noteModel,
  });
  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  final format = DateFormat("yyyy-MM-dd");
  bool _isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenAddNote();
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
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: width * 0.65,
                ),
                GestureDetector(
                  child: Container(
                    width: width * 0.13,
                    height: width * 0.13,
                    alignment: Alignment.center,
                    // padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white.withOpacity(0.7)),
                    child: Icon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNotePage(
                                id: widget.noteModel!.id,
                                newEditFlag: false,
                              )),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: Text(
                        widget.noteModel!.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: Text(
                        widget.noteModel!.body!,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Text(
                            DateFormat('yMMMMd')
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(widget.noteModel!.last_date!)))
                                .toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Text(
                            widget.noteModel!.category!,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNotePage(
                      id: widget.noteModel!.id,
                      newEditFlag: false,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
