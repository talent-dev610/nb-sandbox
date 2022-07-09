import 'package:multi_select_flutter/util/multi_select_item.dart';

class PtCardioDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> cardioDropDownItems = [
    MultiSelectItem(
      0,
      'Within Defined Limits',
    ),
    MultiSelectItem(
      1,
      'Absent pulse(s)',
    ),
    MultiSelectItem(
      2,
      'Chest pain',
    ),
    MultiSelectItem(
      3, // ICU item - etcopy comment
      'Ectopy',
    ),
    MultiSelectItem(
      4,
      'Edema',
    ),
    MultiSelectItem(
      5,
      'Murmur',
    ),
    MultiSelectItem(
      6,
      'Other',
    ),
    MultiSelectItem(
      7, // ICU item - pacemaker comment
      'Pacemaker',
    ),
    MultiSelectItem(
      8, // ICU item - pacer wires
      'Pacer wires',
    ),
    MultiSelectItem(
      9,
      'Pericardial rub',
    ),
    MultiSelectItem(
      10,
      'Pitting edema',
    ),
    MultiSelectItem(
      11,
      'Pulse deficit',
    ),
    MultiSelectItem(
      12,
      'Telemetry',
    ),
    MultiSelectItem(
      13,
      'Weak pulse(s)',
    ),
  ];
  List<MultiSelectItem<int>> cardioDropDownItemsICU = [
  ];
}
