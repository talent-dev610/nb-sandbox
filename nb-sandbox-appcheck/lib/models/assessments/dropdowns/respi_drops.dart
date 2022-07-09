import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtRespiDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> respiDropDownItems = [
    MultiSelectItem(
      0,
      'Within Defined Limits',
    ),
    MultiSelectItem(
      1,
      'Agonal (gasping)',
    ),
    MultiSelectItem(
      2,
      'Apnea',
    ),
    MultiSelectItem(
      3,
      'Asymmetric chest expansion',
    ),
    MultiSelectItem(
      4, // ICU item - bicpap comment
      'BiPAP',
    ),
    MultiSelectItem(
      5,
      'Chest tube',
    ),
    MultiSelectItem(
      6,
      'Clear lung sounds',
    ),
    MultiSelectItem(
      7,
      'Coarseness',
    ),
    MultiSelectItem(
      8, // ICU item - bicpap comment
      'CPAP',
    ),
    MultiSelectItem(
      9,
      'Cough (dry)',
    ),
    MultiSelectItem(
      10,
      'Cough (productive)',
    ),
    MultiSelectItem(
      11,
      'Crackles (coarse)',
    ),
    MultiSelectItem(
      12,
      'Crackles (fine)',
    ),
    MultiSelectItem(
      13,
      'Diminished lung sounds',
    ),
    MultiSelectItem(
      14,
      'Dyspnea during exertion (SOB - shortness of breath)',
    ),
    MultiSelectItem(
      15,
      'Dyspnea during speech (SOB - shortness of breath)',
    ),
    MultiSelectItem(
      16,
      'Expiratory wheezing',
    ),
    MultiSelectItem(
      17,
      'Face mask',
    ),
    MultiSelectItem(
      18,
      'Face mask (non-rebreathing)',
    ),
    MultiSelectItem(
      19,
      'High flow nasal cannula',
    ),
    MultiSelectItem(
      20,
      'Inspiratory wheezing',
    ),
    MultiSelectItem(
      21,
      'Labored breathing',
    ),
    MultiSelectItem(
      22,
      'Oxymizer',
    ),
    MultiSelectItem(
      23,
      'Other',
    ),
    MultiSelectItem(
      24,
      'Pleural rub',
    ),
    MultiSelectItem(
      25,
      'Nasal cannula',
    ),
    MultiSelectItem(
      26,
      'Rhonchi',
    ),
    MultiSelectItem(
      27,
      'Room air',
    ),
    MultiSelectItem(
      28,
      'Shallow breathing',
    ),
    MultiSelectItem(
      29,
      'Stridor',
    ),
    MultiSelectItem(
      30,
      'Symmetric chest expansion',
    ),
    MultiSelectItem(
      31, // ICU item - trach comment
      'Trach collar',
    ),
    MultiSelectItem(
      32, // ICU item - vent comment
      'Ventilator (intubated)',
    ),
    MultiSelectItem(
      33, // ICU item
      'Tracheal deviation (left)',
    ),
    MultiSelectItem(
      34, // ICU item
      'Tracheal deviation (right)',
    ),
  ];

  // Anesthesia Drop Down
  List<DropdownMenuItem> anesthesiaDropList = [
    DropdownMenuItem(
      child: Text('None', style: kDropMenuItemStyle),
      value: 'None',
    ),
    DropdownMenuItem(
  child: Text('Epidural', style: kDropMenuItemStyle),
  value: 'Epidural',
  ),
    DropdownMenuItem(
      child: Text('General', style: kDropMenuItemStyle),
      value: 'General',
    ),

    DropdownMenuItem(
      child: Text('Spinal', style: kDropMenuItemStyle),
      value: 'Spinal',
    ),
  ];
}
