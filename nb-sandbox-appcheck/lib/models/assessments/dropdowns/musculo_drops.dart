import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtMusculoDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> musculoDropDownItems = [
    MultiSelectItem(
      0,
      'Within Defined Limits',
    ),
    MultiSelectItem(
      1,
      'Abdominal binder',
    ),
    MultiSelectItem(
      2,
      'Abductor pillow',
    ),
    MultiSelectItem(
      3,
      'Activity assistance need: independent',
    ),
    MultiSelectItem(
      4,
      'Activity assistance need: 1 person',
    ),
    MultiSelectItem(
      5,
      'Activity assistance need: 2 persons',
    ),
    MultiSelectItem(
      6,
      'Ambulatory  ',
    ),
    MultiSelectItem(
      7,
      'Ambulatory with cane',
    ),
    MultiSelectItem(
      8,
      'Ambulatory with walker',
    ),
    MultiSelectItem(
      9,
      'Antiembolic stockings',
    ),
    MultiSelectItem(
      10,
      'Arterial compression device',
    ),
    MultiSelectItem(
      11,
      'Brace',
    ),
    MultiSelectItem(
      12,
      'Cast',
    ),
    MultiSelectItem(
      13,
      'Cervical collar',
    ),
    MultiSelectItem(
      14,
      'Chest binder',
    ),
    MultiSelectItem(
      15,
      'Continuous passive motion machine',
    ),
    MultiSelectItem(
      16,
      'Eye patch, shield',
    ),
    MultiSelectItem(
      17,
      'Foot boot',
    ),
    MultiSelectItem(
      18,
      'Full range of motion',
    ),
    MultiSelectItem(
      19,
      'Generalized weakness',
    ),
    MultiSelectItem(
      20,
      'Halo',
    ),
    MultiSelectItem(
      21,
      'Helmet',
    ),
    MultiSelectItem(
      22,
      'Ice therapy device',
    ),
    MultiSelectItem(
      23,
      'Immobilizer',
    ),
    MultiSelectItem(
      24,
      'Limited range of motion',
    ),
    MultiSelectItem(
      25,
      'Other',
    ),
    MultiSelectItem(
      26,
      'Pelvic binder',
    ),
    MultiSelectItem(
      27,
      'Post op shoe',
    ),
    MultiSelectItem(
      28,
      'Safety Restraints',
    ),
    MultiSelectItem(
      29,
      'Sequential compression device',
    ),
    MultiSelectItem(
      30,
      'Splint',
    ),
    MultiSelectItem(
      31,
      'Standby Assist',
    ),
    MultiSelectItem(
      32,
      'Traction device',
    ),
    MultiSelectItem(
      33,
      'Unsteady gait',
    ),
    MultiSelectItem(
      34,
      'Warm air device',
    ),
    MultiSelectItem(
      35,
      'Weakness',
    ),
    MultiSelectItem(
      36,
      'Weight bearing: full',
    ),
    MultiSelectItem(
      37,
      'Weight bearing: as tolerated',
    ),
    MultiSelectItem(
      38,
      'Weight bearing: partial (25%)',
    ),
    MultiSelectItem(
      39,
      'Weight bearing: partial (50%)',
    ),
    MultiSelectItem(
      40,
      'Weight bearing: none (bed bound)',
    ),
  ];

  List<DropdownMenuItem> ambuDropList = [
    DropdownMenuItem(
      child: Text(
        'Ambulatory',
        style: kDropMenuItemStyle,
      ),
      value: 'Ambulatory',
    ),
    DropdownMenuItem(
      child: Text(
        'Bathroom',
        style: kDropMenuItemStyle,
      ),
      value: 'Bathroom',
    ),
    DropdownMenuItem(
      child: Text(
        'Bed rest',
        style: kDropMenuItemStyle,
      ),
      value: 'Bed rest',
    ),
    DropdownMenuItem(
      child: Text(
        'Outside',
        style: kDropMenuItemStyle,
      ),
      value: 'Outside',
    ),
  ];
}
