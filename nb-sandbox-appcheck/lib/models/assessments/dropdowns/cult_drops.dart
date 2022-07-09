import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtCultDropDown {
  //Initialize values of dropdown
  List<DropdownMenuItem> cultureDropList = [
    DropdownMenuItem(
      child: Text('American Indian/Alaska Native', style: kDropMenuItemStyle),
      value: 'American Indian/Alaska Native',
    ),
    DropdownMenuItem(
      child: Text('Asian', style: kDropMenuItemStyle),
      value: 'Asian',
    ),
    DropdownMenuItem(
      child: Text('Black or African American', style: kDropMenuItemStyle),
      value: 'Black or African American',
    ),
    DropdownMenuItem(
      child: Text('Hispanic or Latino', style: kDropMenuItemStyle),
      value: 'Hispanic or Latino',
    ),
    DropdownMenuItem(
      child: Text('Native Hawaiian/Other Pacific Islander',
          style: kDropMenuItemStyle),
      value: 'Native Hawaiian/Other Pacific Islander',
    ),
    DropdownMenuItem(
      child: Text('Other', style: kDropMenuItemStyle),
      value: 'Other',
    ),
    DropdownMenuItem(
      child: Text('Unknown', style: kDropMenuItemStyle),
      value: 'Unknown',
    ),
    DropdownMenuItem(
      child: Text('White or Caucasian', style: kDropMenuItemStyle),
      value: 'White or Caucasian',
    ),
  ];
}
