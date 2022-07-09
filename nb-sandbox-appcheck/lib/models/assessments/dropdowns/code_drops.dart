import 'package:flutter/material.dart';

class PtCodeDropDown {
  //Initialize values of dropdown
  List<DropdownMenuItem> codeDropList = [
    DropdownMenuItem(
      child: Text('Full Code'),
      value: 'Full Code',
    ),
    DropdownMenuItem(
      child: Text('DNI - Do Not Intubate'),
      value: 'DNI - Do Not Intubate',
    ),
    DropdownMenuItem(
      child: Text('DNR - Do Not Resuscitate'),
      value: 'DNR - Do Not Resuscitate',
    ),
    DropdownMenuItem(
      child: Text('DNR / DNI - Do Not Resuscitate or Intuabte'),
      value: 'DNR / DNI - Do Not Resuscitate or Intuabte',
    ),
  ];
}
