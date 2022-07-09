import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtDropDown {
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
}
