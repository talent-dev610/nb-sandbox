import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtGenDropDown {
  // Values of dropdown
  List<DropdownMenuItem> genderDropList = [
    DropdownMenuItem(
      child: Text(
        'Agender',
        style: kDropMenuItemStyle,
      ),
      value: 'Agender',
    ),
    DropdownMenuItem(
      child: Text(
        'Androgyne',
        style: kDropMenuItemStyle,
      ),
      value: 'Androgyne',
    ),
    DropdownMenuItem(
      child: Text(
        'Androgynous',
        style: kDropMenuItemStyle,
      ),
      value: 'Androgynous',
    ),
    DropdownMenuItem(
      child: Text(
        'Bigender',
        style: kDropMenuItemStyle,
      ),
      value: 'Bigender',
    ),
    DropdownMenuItem(
      child: Text(
        'Cis',
        style: kDropMenuItemStyle,
      ),
      value: 'Cis',
    ),
    DropdownMenuItem(
      child: Text(
        'Cisgender',
        style: kDropMenuItemStyle,
      ),
      value: 'Cisgender',
    ),
    DropdownMenuItem(
      child: Text(
        'Cis Female',
        style: kDropMenuItemStyle,
      ),
      value: 'Cis Female',
    ),
    DropdownMenuItem(
      child: Text(
        'Cis Male',
        style: kDropMenuItemStyle,
      ),
      value: 'Cis Male',
    ),
    DropdownMenuItem(
      child: Text(
        'Cis Man',
        style: kDropMenuItemStyle,
      ),
      value: 'Cis Man',
    ),
    DropdownMenuItem(
      child: Text(
        'Cis Woman',
        style: kDropMenuItemStyle,
      ),
      value: 'Cis Woman',
    ),
    DropdownMenuItem(
      child: Text(
        'Cisgender Female',
        style: kDropMenuItemStyle,
      ),
      value: 'Cisgender Female',
    ),
    DropdownMenuItem(
      child: Text(
        'Cisgender Male',
        style: kDropMenuItemStyle,
      ),
      value: 'Cisgender Male',
    ),
    DropdownMenuItem(
      child: Text(
        'Cisgender Man',
        style: kDropMenuItemStyle,
      ),
      value: 'Cisgender Man',
    ),
    DropdownMenuItem(
      child: Text(
        'Cisgender Woman',
        style: kDropMenuItemStyle,
      ),
      value: 'Cisgender Woman',
    ),
    DropdownMenuItem(
      child: Text(
        'Female to Male',
        style: kDropMenuItemStyle,
      ),
      value: 'Female to Male',
    ),
    DropdownMenuItem(
      child: Text(
        'Gender Fluid',
        style: kDropMenuItemStyle,
      ),
      value: 'Gender Fluid',
    ),
    DropdownMenuItem(
      child: Text(
        'Gender Nonconforming',
        style: kDropMenuItemStyle,
      ),
      value: 'Gender Nonconforming',
    ),
    DropdownMenuItem(
      child: Text(
        'Genderqueer',
        style: kDropMenuItemStyle,
      ),
      value: 'Genderqueer',
    ),
    DropdownMenuItem(
      child: Text(
        'Gender Questioning',
        style: kDropMenuItemStyle,
      ),
      value: 'Gender Questioning',
    ),
    DropdownMenuItem(
      child: Text(
        'Gender Variant',
        style: kDropMenuItemStyle,
      ),
      value: 'Gender Variant',
    ),
    DropdownMenuItem(
      child: Text(
        'Intersex',
        style: kDropMenuItemStyle,
      ),
      value: 'Intersex',
    ),
    DropdownMenuItem(
      child: Text(
        'Male to Female',
        style: kDropMenuItemStyle,
      ),
      value: 'Male to Female',
    ),
    DropdownMenuItem(
      child: Text(
        'Neither',
        style: kDropMenuItemStyle,
      ),
      value: 'Neither',
    ),
    DropdownMenuItem(
      child: Text(
        'Neutrois',
        style: kDropMenuItemStyle,
      ),
      value: 'Neutrois',
    ),
    DropdownMenuItem(
      child: Text(
        'Non-binary',
        style: kDropMenuItemStyle,
      ),
      value: 'Non-binary',
    ),
    DropdownMenuItem(
      child: Text(
        'Other',
        style: kDropMenuItemStyle,
      ),
      value: 'Other',
    ),
    DropdownMenuItem(
      child: Text(
        'Pangender',
        style: kDropMenuItemStyle,
      ),
      value: 'Pangender',
    ),
    DropdownMenuItem(
      child: Text(
        'Transfeminine',
        style: kDropMenuItemStyle,
      ),
      value: 'Transfeminine',
    ),
    DropdownMenuItem(
      child: Text(
        'Transgender',
        style: kDropMenuItemStyle,
      ),
      value: 'Transgender',
    ),
    DropdownMenuItem(
      child: Text(
        'Transgender Female',
        style: kDropMenuItemStyle,
      ),
      value: 'Transgender Female',
    ),
    DropdownMenuItem(
      child: Text(
        'Transgender Male',
        style: kDropMenuItemStyle,
      ),
      value: 'Transgender Male',
    ),
    DropdownMenuItem(
      child: Text(
        'Transgender Man',
        style: kDropMenuItemStyle,
      ),
      value: 'Transgender Man',
    ),
    DropdownMenuItem(
      child: Text(
        'Transgender Person',
        style: kDropMenuItemStyle,
      ),
      value: 'Transgender Person',
    ),
    DropdownMenuItem(
      child: Text(
        'Transgender Woman',
        style: kDropMenuItemStyle,
      ),
      value: 'Transgender Woman',
    ),
    DropdownMenuItem(
      child: Text(
        'Transmasculine',
        style: kDropMenuItemStyle,
      ),
      value: 'Transmasculine',
    ),
    DropdownMenuItem(
      child: Text(
        'Two-Spirit',
        style: kDropMenuItemStyle,
      ),
      value: 'Two-Spirit',
    ),
  ];

  // Pronoun Drop
  List<DropdownMenuItem> pronounDropList = [
    DropdownMenuItem(
      child: Text(
        'E/ey, em, eir, eirs, eirself',
        style: kDropMenuItemStyle,
      ),
      value: 'E/ey, em, eir, eirs, eirself',
    ),
    DropdownMenuItem(
      child: Text(
        'He, him, his, his, himself',
        style: kDropMenuItemStyle,
      ),
      value: 'He, him, his, his, himself',
    ),
    DropdownMenuItem(
      child: Text(
        'Other pronoun',
        style: kDropMenuItemStyle,
      ),
      value: 'Other pronoun',
    ),
    DropdownMenuItem(
      child: Text(
        'Per, per, pers, pers, perself',
        style: kDropMenuItemStyle,
      ),
      value: 'Per, per, pers, pers, perself',
    ),
    DropdownMenuItem(
      child: Text(
        'She, her, her, hers, herself',
        style: kDropMenuItemStyle,
      ),
      value: 'She, her, her, hers, herself',
    ),
    DropdownMenuItem(
      child: Text(
        'They, them, their, theirs, themself',
        style: kDropMenuItemStyle,
      ),
      value: 'They, them, their, theirs, themself',
    ),
    DropdownMenuItem(
      child: Text(
        'Ve, ver, vis, vis, verself',
        style: kDropMenuItemStyle,
      ),
      value: 'Ve, ver, vis, vis, verself',
    ),
    DropdownMenuItem(
      child: Text(
        'Xe, xem, xyr, xyrs, xemself',
        style: kDropMenuItemStyle,
      ),
      value: 'Xe, xem, xyr, xyrs, xemself',
    ),
    DropdownMenuItem(
      child: Text(
        'Ze/zie, hir, hir, hirs, hirself',
        style: kDropMenuItemStyle,
      ),
      value: 'Ze/zie, hir, hir, hirs, hirself',
    ),
  ];
}
