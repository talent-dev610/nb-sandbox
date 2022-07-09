import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtGenitoDropDown {
  //Initialize values of dropdown
  List<MultiSelectItem<int>> genitoDropDownItems = [
    MultiSelectItem(
      0,
      'Within Defined Limits',
    ),
    MultiSelectItem(
      1,
      'Anuria',
    ),
    MultiSelectItem(
      2,
      'Bedside Commode',
    ),
    MultiSelectItem(
      3,
      'Burning with urination',
    ),
    MultiSelectItem(
      4,
      'Cloudy urine',
    ),
    MultiSelectItem(
      5, // crrt comment ICU
      'Continuous Renal Replacement Therapy',
    ),
    MultiSelectItem(
      6,
      'Foley Catheter (indwelling)',
    ),
    MultiSelectItem(
      7,
      'Foley Catheter (intermittent)',
    ),
    MultiSelectItem(
      8,
      'Hematuria (blood in urine)',
    ),
    MultiSelectItem(
      9,
      'Hernia',
    ),
    MultiSelectItem(
      10, // dialysis comment
      'Hemodialysis',
    ),
    MultiSelectItem(
      11,
      'Inflammation',
    ),
    MultiSelectItem(
      12,
      'Lesions(s)',
    ),
    MultiSelectItem(
      13,
      'Nephrostomy tube',
    ),
    MultiSelectItem(
      14,
      'Odorous urine',
    ),
    MultiSelectItem(
      15,
      'Other',
    ),
    MultiSelectItem(
      16,
      'Penile Discharge',
    ),
    MultiSelectItem(
      17, // dialysis comment
      'Peritoneal dialysis',
    ),
    MultiSelectItem(
      18,
      'Straight (intermittent) dath',
    ),
    MultiSelectItem(
      19,
      'Urinal',
    ),
    MultiSelectItem(
      20,
      'Urinary incontinence',
    ),
    MultiSelectItem(
      21,
      'Urinary urgency',
    ),
    MultiSelectItem(
      22,
      'Urinary tract infection',
    ),
    MultiSelectItem(
      23,
      'Vaginal bleeding',
    ),
    MultiSelectItem(
      24,
      'Vaginal discharge',
    ),
    MultiSelectItem(
      25,
      'Vaginal Odor',
    ),
    MultiSelectItem(
      25,
      'Voiding Freely',
    ),
  ];

  // Fundal drops
  List<DropdownMenuItem> fundalDropList = [
 DropdownMenuItem(
      child: Text('3U', style: kDropMenuItemStyle),
      value: '3U',
    ), DropdownMenuItem(
      child: Text('2U', style: kDropMenuItemStyle),
      value: '2U',
    ), DropdownMenuItem(
      child: Text('1U', style: kDropMenuItemStyle),
      value: '1U',
    ), DropdownMenuItem(
      child: Text('UU', style: kDropMenuItemStyle),
      value: 'UU',
    ), DropdownMenuItem(
      child: Text('U1', style: kDropMenuItemStyle),
      value: 'U1',
    ), DropdownMenuItem(
      child: Text('U2', style: kDropMenuItemStyle),
      value: 'U2',
    ),
    DropdownMenuItem(
      child: Text('U3', style: kDropMenuItemStyle),
      value: 'U3',
    ),
  ];

  // Fundal location drops
  List<DropdownMenuItem> fundalLocationDropList = [
  DropdownMenuItem(
  child: Text('Left lying', style: kDropMenuItemStyle),
  value: 'Left lying',
  ),
    DropdownMenuItem(
      child: Text('Midline', style: kDropMenuItemStyle),
      value: 'Midline',
    ),
    DropdownMenuItem(
      child: Text('Right lying', style: kDropMenuItemStyle),
      value: 'Right lying',
    ),
  ];

  // Lochia drops
  List<DropdownMenuItem> lochiaDropList = [
    DropdownMenuItem(
      child: Text('None', style: kDropMenuItemStyle),
      value: 'None',
    ), DropdownMenuItem(
      child: Text('Scant', style: kDropMenuItemStyle),
      value: 'Scant',
    ), DropdownMenuItem(
      child: Text('Mild', style: kDropMenuItemStyle),
      value: 'Mild',
    ), DropdownMenuItem(
      child: Text('Moderate', style: kDropMenuItemStyle),
      value: 'Moderate',
    ), DropdownMenuItem(
      child: Text('Heavy', style: kDropMenuItemStyle),
      value: 'Heavy',
    ), DropdownMenuItem(
      child: Text('Clots', style: kDropMenuItemStyle),
      value: 'Clots',
    ),
  ];

  // Anesthesia Drop Down
  List<DropdownMenuItem> deliveryDropList = [
    DropdownMenuItem(
      child: Text('Cesarean', style: kDropMenuItemStyle),
      value: 'Cesarean',
    ),
    DropdownMenuItem(
      child: Text('Induction', style: kDropMenuItemStyle),
      value: 'Induction',
    ),
    DropdownMenuItem(
      child: Text('Natural birth', style: kDropMenuItemStyle),
      value: 'Natural birth',
    ),
    DropdownMenuItem(
      child: Text('Vaginal birth', style: kDropMenuItemStyle),
      value: 'Vaginal birth',
    ),
    DropdownMenuItem(
      child: Text('Vaginal birth after c-section (VBAC)', style: kDropMenuItemStyle),
      value: 'Vaginal birth after c-section (VBAC)',
    ),
  ];
}
