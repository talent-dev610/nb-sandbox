import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtNeuroDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> neuroDropDownItems = [
    MultiSelectItem(
      0,
      'Within Defined Limits',
    ),
    MultiSelectItem(
      1,
      'Aphasia',
    ),
    MultiSelectItem(
      2,
      'A/O x1: Person',
    ),
    MultiSelectItem(
      3,
      'A/O x2: Person, Place',
    ),
    MultiSelectItem(
      4,
      'A/O x3: Person, Place, Time',
    ),
    MultiSelectItem(
      5,
      'A/O x4: Person, Place, Time, Event',
    ),
    MultiSelectItem(
      6,
      'Confused',
    ),
    MultiSelectItem(
      7,
      'Delirius',
    ),
    MultiSelectItem(
      8,
      'Does not follow commands',
    ),
    MultiSelectItem(
      9,
      'Dysarthria (Slurred speech)',
    ),
    MultiSelectItem(
      21,
      'EEG Monitoring',
    ),
    MultiSelectItem(
      10,
      'Follows commands',
    ),
    MultiSelectItem(
      11,
      'Forgetful',
    ),
    MultiSelectItem(
      12,
      'Lethargic',
    ),
    MultiSelectItem(
      13,
      'Non Verbal',
    ),
    MultiSelectItem(
      14,
      'Other',
    ),
    MultiSelectItem(
      20, // ICU item
      'Q 1-hour checks',
    ),
    MultiSelectItem(
      15,
      'Rambling speech',
    ),
    MultiSelectItem(
      16,
      'Reorientable',
    ),
    MultiSelectItem(
      17,
      'Sedated',
    ),
    MultiSelectItem(
      18,
      'Stroke (Hemorrhagic)',
    ),
    MultiSelectItem(
      19,
      'Stroke (Ischemic)',
    ),
  ];
  // Fontanel Drop Down
  List<DropdownMenuItem> fontanelDropList = [
  DropdownMenuItem(
  child: Text('Flat', style: kDropMenuItemStyle),
  value: 'Flat',
  ),
  DropdownMenuItem(
  child: Text('Firm', style: kDropMenuItemStyle),
  value: 'Firm',
  ),
  DropdownMenuItem(
  child: Text('Soft', style: kDropMenuItemStyle),
  value: 'Soft',
  ),DropdownMenuItem(
  child: Text('Sunken', style: kDropMenuItemStyle),
  value: 'Sunken',
  ),
  ];
}