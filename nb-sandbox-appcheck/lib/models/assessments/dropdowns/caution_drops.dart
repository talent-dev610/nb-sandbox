import 'package:multi_select_flutter/util/multi_select_item.dart';

class PtCautionDropDown {
  //Initialize values of dropdown

  List<MultiSelectItem<int>> isoDropList = [
    MultiSelectItem(
      0,
      'Standard Precautions',
    ),
    MultiSelectItem(
      1,
      'Airborne Precautions',
    ),
    MultiSelectItem(
      2,
      'Chemotherapy Precautions',
    ),
    MultiSelectItem(
      3,
      'Contact Precautions',
    ),
    MultiSelectItem(
      4,
      'Contact Plus Precautions',
    ),
    MultiSelectItem(
      5,
      'Covid Precautions',
    ),
    MultiSelectItem(
      6,
      'Droplet Precautions',
    ),
    MultiSelectItem(
      7,
      'Neutropenic Precautions',
    ),
    MultiSelectItem(
      8,
      'Other',
    ),
    MultiSelectItem(
      9,
      'Radiation Precautions',
    ),
  ];

  // Alerts Drop Down
  List<MultiSelectItem<int>> alertsDropList = [
    MultiSelectItem(
      0,
      'Blood Sugar Checks (ACHS)',
    ),
    MultiSelectItem(
      1,
      'Crushed Medications (Swallow Precautions)',
    ),
    MultiSelectItem(
      2,
      'Fall Risk',
    ),
    MultiSelectItem(
      3,
      'Fluid Restrictions',
    ),
    MultiSelectItem(
      4,
      'Frequent Rounder',
    ),
    MultiSelectItem(
      5,
      'No BP / IV / Labs (left arm)',
    ),
    MultiSelectItem(
      6,
      'No BP / IV / Labs (right arm)',
    ),
    MultiSelectItem(
      7,
      'NPO except for meds',
    ),
    MultiSelectItem(
      8,
      'Pregnant',
    ),
    MultiSelectItem(
      9,
      'Restraints',
    ),
    MultiSelectItem(
      10,
      'Seizure precautions',
    ),
    MultiSelectItem(
      11,
      'Sitter (safety attendant)',
    ),
    MultiSelectItem(
      12,
      'Strict NPO (nothing by mouth)',
    ),
    MultiSelectItem(
      13,
      'Suicide precautions',
    ),
    MultiSelectItem(
      14,
      'Swallow precautions',
    ),
    MultiSelectItem(
      15,
      'Violent',
    ),
    MultiSelectItem(
      16,
      'Withdrawals precautions',
    ),
  ];

  // ICU Alerts Drop Down
  List<MultiSelectItem<int>> icuAlertsDropList = [
    MultiSelectItem(
      0,
      'Bleeding precautions',
    ),
    MultiSelectItem(
      1,
      'Fall Risk',
    ),
    MultiSelectItem(
      2,
      'Fluid Restrictions',
    ),
    MultiSelectItem(
      3,
      'Frequent Rounder',
    ),
    MultiSelectItem(
      4,
      'Heparin Infusion',
    ),
    MultiSelectItem(
      5,
      'No BP / IV / Labs (left arm)',
    ),
    MultiSelectItem(
      6,
      'No BP / IV / Labs (right arm)',
    ),
    MultiSelectItem(
      7,
      'NPO except for meds',
    ),
    MultiSelectItem(
      8,
      'Pregnant',
    ),
    MultiSelectItem(
      9,
      'Restraints',
    ),
    MultiSelectItem(
      10,
      'Seizure precautions',
    ),
    MultiSelectItem(
      11,
      'Sitter (safety attendant)',
    ),
    MultiSelectItem(
      12,
      'Strict NPO (nothing by mouth)',
    ),
    MultiSelectItem(
      13,
      'Suicide precautions',
    ),
    MultiSelectItem(
      14,
      'Swallow precautions',
    ),
    MultiSelectItem(
      15,
      'Violent',
    ),
    MultiSelectItem(
      16,
      'Withdrawals precautions',
    ),
  ];

  // Alerts Drop Down
  List<MultiSelectItem<int>> risksDropList = [
    MultiSelectItem(
      0,
      'Assault precautions',
    ),
    MultiSelectItem(
      1,
      'Detox/Withdrawals',
    ),
    MultiSelectItem(
      2,
      'Elopement precautions',
    ),
    MultiSelectItem(
      3,
      'Fall precautions',
    ),
    MultiSelectItem(
      4,
      'Homicide precautions',
    ),
    MultiSelectItem(
      5,
      'Other',
    ),
    MultiSelectItem(
      6,
      'Pregnant',
    ),
    MultiSelectItem(
      7,
      'Sexual acting out',
    ),
    MultiSelectItem(
      8,
      'Suicide precautions',
    ),
  ];
}
