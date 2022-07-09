import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PtDisabilityDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> disabilityDropDownItems = [
    MultiSelectItem
      (
      0,
      'No Disability',
    ),
    MultiSelectItem(
      1,
      'Blind or Visually Impaired',
    ),
    MultiSelectItem(
      2,
      'Cognitive Disability',
    ),
    MultiSelectItem(
      3,
      'Deaf or Hard of Hearing',
    ),
    MultiSelectItem(
      4,
      'Emotional Disability',
    ),
    MultiSelectItem(
      5,
      'Learning Disability',
    ),
    MultiSelectItem(
      6,
      'Mental Health Disability',
    ),
    MultiSelectItem(
      7,
      'Other',
    ),
    MultiSelectItem(
      8,
      'Physical Disability',
    ),
    MultiSelectItem(
      9,
      'Speech or Communication Disability',
    ),
  ];
}


