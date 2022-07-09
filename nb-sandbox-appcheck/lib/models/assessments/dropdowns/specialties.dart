import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class SpecialsDropDown {
  // Values of dropdown
  List<DropdownMenuItem> specialsDropList = [
    DropdownMenuItem(
      child: Text(
        'Antepartum',
        style: kDropMenuItemStyle,
      ),
      value: 'Antepartum',
    ),
    DropdownMenuItem(
      child: Text(
        'Gynecology',
        style: kDropMenuItemStyle,
      ),
      value: 'Gynecology',
    ),
    DropdownMenuItem(
      child: Text(
        'Intensive Care',
        style: kDropMenuItemStyle,
      ),
      value: 'Intensive Care',
    ),
    DropdownMenuItem(
      child: Text(
        'MedSurg / Tele',
        style: kDropMenuItemStyle,
      ),
      value: 'MedSurg / Tele',
    ),
    DropdownMenuItem(
      child: Text(
        'Pediatrics',
        style: kDropMenuItemStyle,
      ),
      value: 'Pediatrics',
    ),
    DropdownMenuItem(
      child: Text(
        'Postpartum',
        style: kDropMenuItemStyle,
      ),
      value: 'Postpartum',
    ),
    DropdownMenuItem(
      child: Text(
        'Psychiatry',
        style: kDropMenuItemStyle,
      ),
      value: 'Psychiatry',
    ),
  ];
}
