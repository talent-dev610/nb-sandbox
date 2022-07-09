import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtGastroDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> gastroDropList = [
    MultiSelectItem(
      0,
      'Within Defined Limits',
    ),
    MultiSelectItem(
      1,
      'Abdominal pain',
    ),
    MultiSelectItem(
      2,
      'Abdominal mass',
    ),
    MultiSelectItem(
      3,
      'Abdominal tenderness',
    ),
    MultiSelectItem(
      4,
      'Absent bowel sounds',
    ),
    MultiSelectItem(
      5,
      'Ascites (excess abdominal fluid)',
    ),
    MultiSelectItem(
      6,
      'Bedside Commode',
    ),
    MultiSelectItem(
      7,
      'Blood in stool',
    ),
    MultiSelectItem(
      8,
      'Constipation',
    ),
    MultiSelectItem(
      9,
      'Diarrhea',
    ),
    MultiSelectItem(
      10,
      'Dobhoff tube',
    ),
    MultiSelectItem(
      11,
      'Fair Appetite',
    ),
    MultiSelectItem(
      12,
      'Good Appetite',
    ),
    MultiSelectItem(
      13,
      'Hematemesis (vomiting blood)',
    ),
    MultiSelectItem(
      14,
      'Hemorrhoid(s)',
    ),
    MultiSelectItem(
      15,
      'Hyperactive bowel sounds',
    ),
    MultiSelectItem(
      16,
      'Hypoactive bowel sounds',
    ),
    MultiSelectItem(
      17,
      'Incontinent',
    ),
    MultiSelectItem(
      18,
      'Lesions(s)',
    ),
    MultiSelectItem(
      19,
      'Nausea',
    ),
    MultiSelectItem(
      20,
      'Nasogastric tube',
    ),
    MultiSelectItem(
      21,
      'Nasojejunal tube',
    ),
    MultiSelectItem(
      22,
      'Orogastric tube',
    ),

    MultiSelectItem(
      23,
      'Other',
    ),
    MultiSelectItem(
      24,
      'Passing gas',
    ),
    MultiSelectItem(
      25,
      'PEG tube',
    ),
    MultiSelectItem(
      26,
      'Poor appetite',
    ),
    MultiSelectItem(
      27,
      'Rectal tube',
    ),
    MultiSelectItem(
      28,
      'Vomiting',
    ),
  ];

  // Diet Drop Down
  List<DropdownMenuItem> dietDropList = [
    DropdownMenuItem(
      child: Text('Cardiac Diet', style: kDropMenuItemStyle),
      value: 'Cardiac Diet',
    ),
    DropdownMenuItem(
      child: Text('Clear Liquid Diet', style: kDropMenuItemStyle),
      value: 'Clear Liquid Diet',
    ),
    DropdownMenuItem(
      child: Text('Diabetic Diet', style: kDropMenuItemStyle),
      value: 'Diabetic Diet',
    ),
    DropdownMenuItem(
      child: Text('Full Liquid Diet', style: kDropMenuItemStyle),
      value: 'Full Liquid Diet',
    ),
    DropdownMenuItem(
      child: Text('Low Carbohydrates Diet', style: kDropMenuItemStyle),
      value: 'Low Carbohydrates Diet',
    ),
    DropdownMenuItem(
      child: Text('Low Sodium Diet', style: kDropMenuItemStyle),
      value: 'Low Sodium Diet',
    ),
    DropdownMenuItem(
      child: Text('Mechanical Soft Diet', style: kDropMenuItemStyle),
      value: 'Mechanical Soft Diet',
    ),
    DropdownMenuItem(
      child: Text('Neutropenic Diet', style: kDropMenuItemStyle),
      value: 'Neutropenic Diet',
    ),
    DropdownMenuItem(
      child: Text('NPO except for meds (nothing by mouth except medication)',
          style: kDropMenuItemStyle),
      value: 'NPO except for meds (nothing by mouth except medication)',
    ),
    DropdownMenuItem(
      child: Text('Other', style: kDropMenuItemStyle),
      value: 'Other',
    ),
    DropdownMenuItem(
      child: Text('Regular Diet', style: kDropMenuItemStyle),
      value: 'Regular Diet',
    ),
    DropdownMenuItem(
      child: Text('Renal Diet', style: kDropMenuItemStyle),
      value: 'Renal Diet',
    ),
    DropdownMenuItem(
      child: Text('Strict NPO (nothing by mouth)', style: kDropMenuItemStyle),
      value: 'Strict NPO (nothing by mouth)',
    ),
    DropdownMenuItem(
      child: Text('Tube Feeding', style: kDropMenuItemStyle),
      value: 'Tube Feeding',
    ),
    DropdownMenuItem(
      child: Text('Vegan Diet', style: kDropMenuItemStyle),
      value: 'Vegan Diet',
    ),
    DropdownMenuItem(
      child: Text('Vegetarian Diet', style: kDropMenuItemStyle),
      value: 'Vegetarian Diet',
    ),
  ];
}
