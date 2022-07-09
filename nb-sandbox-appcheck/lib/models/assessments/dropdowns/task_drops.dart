import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class TaskDropDown {
  // Values of dropdown
  List<DropdownMenuItem> taskCatList = [
    DropdownMenuItem(
      child: Row(
        children: [
          Text(
            'Medication',
            style: TextStyle(
              color: kGreySky,
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: 4.0),
          Icon(
            FontAwesomeIcons.pills,
            color: Colors.grey[400],
          ),
        ],
      ),
      value: 'Medication',
    ),
    DropdownMenuItem(
      child: Text(
        'Admission',
        style: kDropMenuItemStyle,
      ),
      value: 'Admission',
    ),
    DropdownMenuItem(
      child: Text(
        'Administrative',
        style: kDropMenuItemStyle,
      ),
      value: 'Administrative',
    ),
    DropdownMenuItem(
      child: Text(
        'Assessment',
        style: kDropMenuItemStyle,
      ),
      value: 'Assessment',
    ),
    DropdownMenuItem(
      child: Text(
        'Bedside Care',
        style: kDropMenuItemStyle,
      ),
      value: 'Bedside Care',
    ),
    DropdownMenuItem(
      child: Text(
        'Discharge',
        style: kDropMenuItemStyle,
      ),
      value: 'Discharge',
    ),
    DropdownMenuItem(
      child: Text(
        'Documentation',
        style: kDropMenuItemStyle,
      ),
      value: 'Documentation',
    ),
    DropdownMenuItem(
      child: Text(
        'Dressing Change',
        style: kDropMenuItemStyle,
      ),
      value: 'Dressing Change',
    ),
    DropdownMenuItem(
      child: Text(
        'General',
        style: kDropMenuItemStyle,
      ),
      value: 'General',
    ),
    DropdownMenuItem(
      child: Text(
        'High Alert',
        style: kDropMenuItemStyle,
      ),
      value: 'High Alert',
    ),
    DropdownMenuItem(
      child: Text(
        'Imaging',
        style: kDropMenuItemStyle,
      ),
      value: 'Imaging',
    ),
    DropdownMenuItem(
      child: Text(
        'Input / Output',
        style: kDropMenuItemStyle,
      ),
      value: 'Input / Output',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Text(
            'Labs',
            style: TextStyle(
              color: kGreySky,
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: 4.0),
          Icon(
            FontAwesomeIcons.vial,
            color: Colors.grey[400],
          ),
        ],
      ),
      value: 'Labs',
    ),
    DropdownMenuItem(
      child: Text(
        'Lines / Drains',
        style: kDropMenuItemStyle,
      ),
      value: 'Lines / Drains',
    ),
    DropdownMenuItem(
      child: Text(
        'Miscellaneous',
        style: kDropMenuItemStyle,
      ),
      value: 'Miscellaneous',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Text(
            'Procedures',
            style: TextStyle(
              color: kGreySky,
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: 4.0),
          Icon(
            FontAwesomeIcons.cut,
            color: Colors.grey[400],
          ),
        ],
      ),
      value: 'Procedures',
    ),
    DropdownMenuItem(
      child: Text(
        'Safety',
        style: kDropMenuItemStyle,
      ),
      value: 'Safety',
    ),
    DropdownMenuItem(
      child: Text(
        'Teaching',
        style: kDropMenuItemStyle,
      ),
      value: 'Teaching',
    ),
    DropdownMenuItem(
      child: Text(
        'Wound Care',
        style: kDropMenuItemStyle,
      ),
      value: 'Wound Care',
    ),
  ];
  // Repeatations
  List<DropdownMenuItem> repeatationsList = [
    DropdownMenuItem(
      child: Text(
        '5M',
        style: kDropMenuItemStyle,
      ),
      value: '5',
    ),
    DropdownMenuItem(
      child: Text(
        '10M',
        style: kDropMenuItemStyle,
      ),
      value: '10',
    ),
    DropdownMenuItem(
      child: Text(
        '15M',
        style: kDropMenuItemStyle,
      ),
      value: '15',
    ),
    DropdownMenuItem(
      child: Text(
        '30M',
        style: kDropMenuItemStyle,
      ),
      value: '30',
    ),
    DropdownMenuItem(
      child: Text(
        '1H',
        style: kDropMenuItemStyle,
      ),
      value: '60',
    ),
    DropdownMenuItem(
      child: Text(
        '2H',
        style: kDropMenuItemStyle,
      ),
      value: '120',
    ),
    DropdownMenuItem(
      child: Text(
        '3H',
        style: kDropMenuItemStyle,
      ),
      value: '180',
    ),
    DropdownMenuItem(
      child: Text(
        '4H',
        style: kDropMenuItemStyle,
      ),
      value: '240',
    ),
    DropdownMenuItem(
      child: Text(
        '6H',
        style: kDropMenuItemStyle,
      ),
      value: '360',
    ),
    DropdownMenuItem(
      child: Text(
        '8H',
        style: kDropMenuItemStyle,
      ),
      value: '480',
    ),
    DropdownMenuItem(
      child: Text(
        '12H',
        style: kDropMenuItemStyle,
      ),
      value: '720',
    ),
    DropdownMenuItem(
      child: Text(
        '24H',
        style: kDropMenuItemStyle,
      ),
      value: '1440',
    ),
  ];

// RepeatationsCount
  List<DropdownMenuItem> repeatationCountList = [
    DropdownMenuItem(
      child: Text(
        '1',
        style: kDropMenuItemStyle,
      ),
      value: '1',
    ),
    DropdownMenuItem(
      child: Text(
        '2',
        style: kDropMenuItemStyle,
      ),
      value: '2',
    ),
    DropdownMenuItem(
      child: Text(
        '3',
        style: kDropMenuItemStyle,
      ),
      value: '3',
    ),
    DropdownMenuItem(
      child: Text(
        '4',
        style: kDropMenuItemStyle,
      ),
      value: '4',
    ),
    DropdownMenuItem(
      child: Text(
        '5',
        style: kDropMenuItemStyle,
      ),
      value: '5',
    ),
    DropdownMenuItem(
      child: Text(
        '6',
        style: kDropMenuItemStyle,
      ),
      value: '6',
    ),
    DropdownMenuItem(
      child: Text(
        '7',
        style: kDropMenuItemStyle,
      ),
      value: '7',
    ),
    DropdownMenuItem(
      child: Text(
        '8',
        style: kDropMenuItemStyle,
      ),
      value: '8',
    ),
    DropdownMenuItem(
      child: Text(
        '9',
        style: kDropMenuItemStyle,
      ),
      value: '9',
    ),
    DropdownMenuItem(
      child: Text(
        '10',
        style: kDropMenuItemStyle,
      ),
      value: '10',
    ),
  ];
  // Priority Drop Down
  List<DropdownMenuItem> taskPriorityList = [
    DropdownMenuItem(
      child: Text(
        'High',
        style: kDropMenuItemStyle,
      ),
      value: 'High',
    ),
    DropdownMenuItem(
      child: Text(
        'Medium',
        style: kDropMenuItemStyle,
      ),
      value: 'Medium',
    ),
    DropdownMenuItem(
      child: Text(
        'Low',
        style: kDropMenuItemStyle,
      ),
      value: 'Low',
    ),
  ];
  // Priority Drop Dow
  List<DropdownMenuItem> taskReminderList = [
    DropdownMenuItem<int>(
      child: Text(
        '5 min',
        style: kDropMenuItemStyle,
      ),
      value: 5,
    ),
    DropdownMenuItem<int>(
      child: Text(
        '10 min',
        style: kDropMenuItemStyle,
      ),
      value: 10,
    ),
    DropdownMenuItem<int>(
      child: Text(
        '15 min',
        style: kDropMenuItemStyle,
      ),
      value: 15,
    ),
    DropdownMenuItem<int>(
      child: Text(
        '30 min',
        style: kDropMenuItemStyle,
      ),
      value: 30,
    ),
    DropdownMenuItem<int>(
      child: Text(
        '1 hour',
        style: kDropMenuItemStyle,
      ),
      value: 60,
    ),
    DropdownMenuItem<int>(
      child: Text(
        '2 hours',
        style: kDropMenuItemStyle,
      ),
      value: 120,
    ),
  ];
}
