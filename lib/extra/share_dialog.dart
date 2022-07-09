import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sbarsmartbrainapp/main.dart';
import 'package:sbarsmartbrainapp/models/todo.dart';
import 'package:sbarsmartbrainapp/qr_share.dart';
import 'package:sbarsmartbrainapp/services/backend.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:universal_platform/universal_platform.dart';

import '../models/patients/patient.dart';

class ShareDialog extends StatelessWidget {
  List<Patient> patients;
  bool? isAssignRoutine = false;

  ShareDialog(this.patients, {this.isAssignRoutine});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<int>(
        stream: QRShare().getDialog,
        initialData: 0,
        builder: (context, snapshot) {
          return snapshot.data == 0
              ? AlertDialog(
                  title: patients.length > 0
                      ? StreamBuilder<List<bool?>>(
                          stream: QRShare().getSelected,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const SizedBox();
                            return ElevatedButton(
                              onPressed: snapshot.data!.contains(false)
                                  ? QRShare().selectAll
                                  : QRShare().unSelectAll,
                              child: Text(snapshot.data!.contains(false)
                                  ? 'Select All'
                                  : 'Unselect all'),
                            );
                          })
                      : const SizedBox(),
                  content: SizedBox(
                    width: size.width * 0.75,
                    height: size.height * 0.4,
                    child: (patients.length == 0)
                        ? Center(child: Text('No patients'))
                        : StreamBuilder<List<bool?>>(
                            stream: QRShare().getSelected,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const SizedBox();
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      title: Text(
                                        "${patients[index].nicknameField!.toUpperCase()} (Room - ${patients[index].roomNumberField})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      value: snapshot.data![index],
                                      onChanged: (b) {
                                        QRShare().select(index, b);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    );
                                  },
                                  itemCount: patients.length);
                            }),
                  ),
                  actions: [
                    if (isAssignRoutine != true)
                      StreamBuilder<List<bool?>>(
                          stream: QRShare().getSelected,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                                onPressed: snapshot.hasData &&
                                        snapshot.data!.contains(true)
                                    ? () {
                                        QRShare().isQRVisible = true;
                                        QRShare().addDialog(1);
                                      }
                                    : null,
                                child: Text('Share QR'));
                          }),
                    if (isAssignRoutine != true)
                      StreamBuilder<List<bool?>>(
                          stream: QRShare().getSelected,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                                onPressed: snapshot.hasData &&
                                        snapshot.data!.contains(true)
                                    ? () async {
                                        Navigator.of(context).pop();
                                        await QRShare().sharePDF();
                                      }
                                    : null,
                                child: Text('Print PDF'));
                          }),
                    if (isAssignRoutine == true)
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            List<Patient> _selectedPatient =
                                QRShare().getSelectedPatients();
                            var _res = await Backend().getTemplate();
                            var id = _res.length > 0 ? _res.first['id'] : '';
                            List _myTemplate =
                                _res.length > 0 ? _res.first['template'] : [];
                            List<TodoClass> _todoList = _myTemplate
                                .map((e) => TodoClass.fromMap(e))
                                .toList();
                            for (var patient in _selectedPatient) {
                              for (var todo in _todoList) {
                                TodoClass _newTodo = todo;
                                _newTodo.ptId = patient.id;
                                _newTodo.todoPt =
                                    (patient.nicknameField ?? 'None') +
                                        '***' +
                                        patient.id!;
                                _newTodo.publicPtValue =
                                    patient.nicknameField ?? 'None';
                                try {
                                  await Backend().addTask(_newTodo);
                                  bool onTime =
                                      DateTime.now().millisecondsSinceEpoch >
                                          todo.exactDue!;
                                  if (!UniversalPlatform.isWeb) {
                                    await defaultReminderNotification(
                                        todo.reminderId!,
                                        todo.todoTitle!.trim(),
                                        todo.todoDesc!.trim(),
                                        patient.nicknameField);
                                  }
                                } catch (e) {}
                              }
                            }
                            Navigator.pop(context);
                          },
                          child: Text('Assign Routine to Patient(s)'),
                        ),
                      )
                  ],
                )
              : AlertDialog(
                  content: SizedBox(
                    width: min(size.width * 0.75, size.height * 0.5),
                    height: min(size.width * 0.75, size.height * 0.5),
                    child: QrImage(
                      data: QRShare().getQRData(),
                      version: QrVersions.auto,
                    ),
                  ),
                );
        });
  }
}

defaultReminderNotification(
    int id, String title, String description, String? patientName) async {
  var _selectDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().add(Duration(days: 1)).day,
      TimeOfDay.now().hour,
      TimeOfDay.now().minute,
      DateTime.now().second);

  tz.initializeTimeZones();
  var defaultNotificationDateTime =
      tz.TZDateTime.from(_selectDate, tz.local).add(Duration(minutes: -0));
  var android = AndroidNotificationDetails('channelId', 'channelDescription',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = new NotificationDetails(android: android, iOS: iOS);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      // Modify notification title, description
      id,
      'Due Now: $title - Patient: $patientName}',
      '$description',
      defaultNotificationDateTime,
      platform,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
