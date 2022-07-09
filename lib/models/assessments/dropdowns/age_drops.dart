import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtAgeDropDown {
  //Initialize values of dropdown
  List<DropdownMenuItem> ageDropList = [
    DropdownMenuItem(
      child: Text('Days Old', style: kDropMenuItemStyle),
      value: 'Days Old',
    ),
    DropdownMenuItem(
      child: Text('Weeks Old', style: kDropMenuItemStyle),
      value: 'Weeks Old',
    ),
    DropdownMenuItem(
      child: Text('Months Old', style: kDropMenuItemStyle),
      value: 'Months Old',
    ),
    DropdownMenuItem(
      child: Text('Years Old', style: kDropMenuItemStyle),
      value: 'Years Old',
    ),
  ];
}
