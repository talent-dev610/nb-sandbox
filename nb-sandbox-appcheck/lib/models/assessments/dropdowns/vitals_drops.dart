import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class PtVitalsDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> vitalsDropDownItems = [
    MultiSelectItem(
      0,
      'Vital Signs Stable',
    ),
    MultiSelectItem(
      1,
      'Bradycardia',
    ),
    MultiSelectItem(
      2,
      'Bradypnea',
    ),
    MultiSelectItem(
      3,
      'Febrile',
    ),
    MultiSelectItem(
      4,
      'Hypertension',
    ),
    MultiSelectItem(
      5,
      'Hypotension',
    ),
    MultiSelectItem(
      6,
      'Hypoxia',
    ),
    MultiSelectItem(
      7,
      'Other',
    ),
    MultiSelectItem(
      8,
      'Tachycardia',
    ),
    MultiSelectItem(
      9,
      'Tachypnea',
    ),
  ];
}
