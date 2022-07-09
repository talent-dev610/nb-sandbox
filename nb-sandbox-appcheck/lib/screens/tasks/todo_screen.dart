import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sbarsmartbrainapp/main.dart';
import 'package:sbarsmartbrainapp/screens/tasks/edit_task.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:universal_platform/universal_platform.dart';

import '../../models/todo.dart';
import '../../services/backend.dart';
import '../../supps/constants.dart';
import 'add_task.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<TodoClass>? todoClass;
  bool emptyList = true;
  bool onTime = true;
  List? myTemplate = [];
  var id;
  getMyTemplate() async {
    var _res = await Backend().getTemplate();
    id = _res.length > 0 ? _res.first['id'] : '';
    myTemplate = _res.length > 0 ? _res.first['template'] : [];
    setState(() {});
  }

  @override
  void initState() {
    getMyTemplate();
    super.initState();
  }

  // Design Scheme
  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenTodo();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          !emptyList
              ? IconButton(
                  icon: Icon(
                    FontAwesomeIcons.circleInfo,
                    color: Colors.white,
                    size: 18.0,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Screen Guide'),
                        content: Container(
                          height: 225,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Todo List Items',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Tap once to view options'),
                              Text('Double tap to edit'),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Action Button (+)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Tap once to add a new task'),
                            ],
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
                    CustomAnalytics().dialTodoGuide();
                  },
                )
              : const SizedBox(),
        ],
        title: !emptyList
            ? Center(
                child: Text(
                  todoClass!.length == 1
                      ? ('1 Task Due')
                      : ('${todoClass!.length} Tasks Due'),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox(),
        elevation: 0.0,
        backgroundColor: kDarkSky,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Backend().taskStream1,
        builder: (context, snapshot) {
          if (snapshot.data == null ||
              (snapshot.hasData && snapshot.data!.size == 0)) {
            emptyList = true;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  child: Card(
                    // color: Colors.orangeAccent[100],
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.solidCheckCircle,
                          color: kRichGrass,
                        ),
                      ),
                      title: Text(
                        'All caught up!',
                        style: kCaughtUpStyle,
                      ),
                      subtitle: Text(
                        'Tap here to add a task and get a reminder when it\'s due',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: _goToAddTask,
                ),
              ),
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              todoClass = snapshot.data!.docs
                  .map((e) =>
                      TodoClass.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
            });
          });
          // try sorting
          try {
            if (todoClass != null) {
              todoClass!.sort((a, b) => a.exactDue!.compareTo(b.exactDue!));
            }
          } catch (e) {
            print(e);
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              emptyList = false;
              if (constraints.maxWidth < 768) {
                return todoGrid(2);
              } else if (constraints.maxWidth >= 768 &&
                  constraints.maxWidth < 1200) {
                return todoGrid(4);
              } else
                return todoGrid(6);
            },
          );
        },
      ),
      floatingActionButton: SpeedDial(
          overlayOpacity: 0.0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: FontAwesomeIcons.plus,
          children: [
            SpeedDialChild(
              backgroundColor: kDawnSky,
              foregroundColor: Colors.white,
              label: 'New Task',
              child: Icon(
                Icons.add_task,
                size: 26,
              ),
              onTap: () {
                _goToAddTask();
              },
            ),
          ]),
    );
  }

  var todo;

  Widget todoGrid(cols) => GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        childAspectRatio: 1.95,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      itemBuilder: (context, index) {
        final tasks = todoClass![index];
        //
        // logic for adding minutes to due datetime when completes iteration
        //
        int minutetobeAdd =
            (tasks.completedRepeatCount ?? '0') == (tasks.repeatCount ?? '1')
                ? ((int.parse(tasks.repeatCount!) - 1) *
                    (int.parse(tasks.repeatationFrequency ?? '0')))
                : ((int.parse(tasks.completedRepeatCount ?? '0') < 0
                        ? 1
                        : int.parse(tasks.completedRepeatCount ?? '0')) *
                    (int.parse(tasks.repeatationFrequency ?? '0')));

        var date = DateFormat('MM/dd/yyyy hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(tasks.exactDue!)
                .add(Duration(minutes: minutetobeAdd)));
        var modifiedDateString = date.replaceFirst(' ', ' @ ');

        return GestureDetector(
          onTap: () {
            taskDialog(index);
          },
          onDoubleTap: () {
            todo = tasks;
            _goToEditTask();
          },
          child: GridTile(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tasks.todoTitle!,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (tasks.isRepeatable ?? false)
                          Text(
                              '${tasks.completedRepeatCount ?? 0}/${tasks.repeatCount}'),
                      ],
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Visibility(
                      visible: tasks.todoDesc != '',
                      child: Text(
                        tasks.todoDesc!,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: kNightSky,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Task demographics
                  ],
                ),
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tasks.publicPtValue == null
                        ? ''
                        : 'Patient: ${tasks.publicPtValue} ',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.blue[700],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        tasks.todoCat!,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: kMidNightSkyBlend,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Visibility(
                        visible: tasks.todoRank == 'High' ||
                            tasks.todoRank == 'Medium',
                        child: Icon(
                          tasks.todoCat == 'Medication'
                              ? FontAwesomeIcons.pills
                              : FontAwesomeIcons.solidCircle,
                          size: tasks.todoCat == 'Medication' ? 14 : 10,
                          color: tasks.todoRank == 'High'
                              ? Colors.red[400]
                              : kDawnSky,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: [
                      if (tasks.isRepeatable != null && tasks.isRepeatable!)
                        Text(
                          tasks.exactDue != 0
                              ? 'Due: $modifiedDateString'
                              : '(please update due time)',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: taskColor(tasks.exactDue),
                          ),
                        ),
                      // for versions that don't have repeatable tasks yet
                      if (tasks.isRepeatable == null)
                        Text(
                          tasks.exactDue != 0
                              ? 'Due: ${tasks.todoDate} @ ${tasks.todoStart}'
                              : '(please update due time)',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: taskColor(tasks.exactDue),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      padding:
          const EdgeInsets.only(top: 0.0, left: 2.0, right: 2.0, bottom: 4.0),
      shrinkWrap: true,
      itemCount: todoClass != null ? (todoClass!.length!) : 0);

  Color? taskColor(due) {
    int hour = 3600000; // 1 hour in milliseconds
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    try {
      if (currentTime >= due) {
        onTime = false;
        return Colors.red;
      } else if (due - (2 * hour) < currentTime && currentTime < due) {
        return Colors.orange[800];
      } else
        return kRichGrass;
    } catch (e) {
      return kRichGrass;
    }
  }

  Future taskDialog(index) async {
    final tasks = todoClass![index];

    //
    // logic for adding minutes to due datetime when completes iteration
    //
    int minutetobeAdd =
        (tasks.completedRepeatCount ?? '0') == (tasks.repeatCount ?? '1')
            ? ((int.parse(tasks.repeatCount!) - 1) *
                (int.parse(tasks.repeatationFrequency ?? '0')))
            : ((int.parse(tasks.completedRepeatCount ?? '0') < 0
                    ? 1
                    : int.parse(tasks.completedRepeatCount ?? '0')) *
                (int.parse(tasks.repeatationFrequency ?? '0')));

    var date = DateFormat('MM/dd/yyyy hh:mm a').format(
        DateTime.fromMillisecondsSinceEpoch(tasks.exactDue!)
            .add(Duration(minutes: minutetobeAdd)));
    var modifiedDateString = date.replaceFirst(' ', ' @ ');
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Center(
                child: Column(
                  children: [
                    Text(tasks.todoTitle!),
                    Wrap(
                      children: [
                        Text(
                          tasks.publicPtValue == null
                              ? ''
                              : 'Patient: ${tasks.publicPtValue}, ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.blue[700],
                          ),
                        ),
                        Text(
                          tasks.todoCat!,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: kMidNightSkyBlend,
                          ),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Icon(
                          tasks.todoCat == 'Medication'
                              ? FontAwesomeIcons.pills
                              : FontAwesomeIcons.solidCircle,
                          size: 12,
                          color: tasks.todoRank == 'High'
                              ? Colors.red[400]
                              : kDawnSky,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        if (tasks.isRepeatable != null && tasks.isRepeatable!)
                          Text(
                            tasks.exactDue != 0
                                ? 'Due: $modifiedDateString'
                                : '(please update due time)',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: taskColor(tasks.exactDue),
                            ),
                          ),
                        if (tasks.isRepeatable != null && !tasks.isRepeatable!)
                          Text(
                            tasks.exactDue != 0
                                ? 'Due: ${tasks.todoDate} @ ${tasks.todoStart}'
                                : '(please update due time)',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: taskColor(tasks.exactDue),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        content: Container(
          height: 75,
          width: 150,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: tasks.todoDesc != '' && tasks.todoDesc != null,
                  child: Text(tasks.todoDesc!),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Complete current iteration
              if ((tasks.isRepeatable ?? false) &&
                  (tasks.completedRepeatCount ?? '0') != (tasks.repeatCount))
                TextButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                  ),
                  child: Text('Complete',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () async {
                    // dermine if task is late
                    completeTask(tasks);
                    Navigator.pop(context);
                  },
                ),
              // Duplicate button
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                child: Text('Duplicate',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () async {
                  // dermine if task is late
                  saveTaskToDb(tasks);
                  Navigator.pop(context);
                  todo = tasks;
                  _goToEditTask();
                },
              ),
              // Delete button
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[600],
                ),
                child: Text('Delete',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () async {
                  if (tasks.reminderId != null) {
                    await flutterLocalNotificationsPlugin
                        .cancel(tasks.reminderId!);
                  }
                  if (tasks.reminderIds!.isNotEmpty) {
                    for (var id in tasks.reminderIds!) {
                      await flutterLocalNotificationsPlugin.cancel(id);
                    }
                  }
                  // dermine if task is late
                  await Backend().deleteTask(todoClass![index]);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              // Edit button
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('Edit',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () {
                  Navigator.pop(context);
                  todo = tasks;
                  _goToEditTask();
                },
              ),
            ],
          )
        ],
      ),
      barrierDismissible: true,
    );
  }

  completeTask(TodoClass task) async {
    await Backend().completeCurTask(task);
  }

  saveTaskToDb(TodoClass task) async {
    await Backend().addTask(task);
    bool onTime = DateTime.now().millisecondsSinceEpoch > task.exactDue!;

    /// Add early reminder
    /*if (isReminder && !UniversalPlatform.isWeb) {
                            setReminderNotification(
                                tasks.reminderId, title.trim(), desc.trim());
                          }*/
    if (!UniversalPlatform.isWeb) {
      defaultReminderNotification(task.reminderId!, task.todoTitle!.trim(),
          task.todoDesc!.trim(), task);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: kMediumSnack,
        backgroundColor: kMidNightSkyBlend,
        content: Text(
          'Task added!',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  defaultReminderNotification(
      int id, String title, String description, TodoClass task) async {
    tz.initializeTimeZones();
    var reminderTime = DateTime.fromMicrosecondsSinceEpoch(task.reminderTime!);
    var defaultNotificationDateTime =
        tz.TZDateTime.from(reminderTime, tz.local).add(Duration(minutes: -0));
    var android = AndroidNotificationDetails('channelId', 'channelDescription',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        // Modify notification title, description
        id,
        'Due Now: $title - Patient: ${task.publicPtValue}',
        '$description',
        defaultNotificationDateTime,
        platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  _goToAddTask() async {
    final addTask = await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AddTask(),
      ),
    );
    if (addTask == 1) {
    } else {}
  }

  _goToEditTask() async {
    final result = await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => EditTask(todo: todo),
      ),
    );
    if (result == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: kMediumSnack,
          backgroundColor: kMidNightSkyBlend,
          content: Text(
            'Task edited!',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      );
    } else {}
  }
}
