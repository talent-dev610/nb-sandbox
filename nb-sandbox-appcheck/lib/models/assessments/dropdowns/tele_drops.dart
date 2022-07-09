import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class PtTeleDropDown {
  //Initialize values of dropdown
  List<DropdownMenuItem> teleDropList = [
    DropdownMenuItem(
      child: Text('Atrial fibrillation - A fib', style: kDropMenuItemStyle),
      value: 'Atrial fibrillation - A fib',
    ),
    DropdownMenuItem(
      child: Text('Atrial flutter', style: kDropMenuItemStyle),
      value: 'Atrial flutter',
    ),
    DropdownMenuItem(
      child: Text('Bradycardia', style: kDropMenuItemStyle),
      value: 'Bradycardia',
    ),
    DropdownMenuItem(
      child: Text('First degree block', style: kDropMenuItemStyle),
      value: 'First degree block',
    ),
    DropdownMenuItem(
      child: Text('Idioventricular rhythm', style: kDropMenuItemStyle),
      value: 'Idioventricular rhythm',
    ),
    DropdownMenuItem(
      child: Text('Irregular rhythm', style: kDropMenuItemStyle),
      value: 'Irregular rhythm',
    ),
    DropdownMenuItem(
      child: Text('Junctional Rhythm', style: kDropMenuItemStyle),
      value: 'Junctional Rhythm',
    ),
    DropdownMenuItem(
      child: Text('Multifocal Atrial Tachycardia - MAT',
          style: kDropMenuItemStyle),
      value: 'Multifocal Atrial Tachycardia - MAT',
    ),
    DropdownMenuItem(
      child: Text('Normal Sinus Rhythm - NSR', style: kDropMenuItemStyle),
      value: 'Normal Sinus Rhythm - NSR',
    ),
    DropdownMenuItem(
      child: Text('Other', style: kDropMenuItemStyle),
      value: 'Other',
    ),
    DropdownMenuItem(
      child: Text('Pacemaker - atrial paced', style: kDropMenuItemStyle),
      value: 'Pacemaker - atrial paced',
    ),
    DropdownMenuItem(
      child: Text('Pacemaker - AV paced', style: kDropMenuItemStyle),
      value: 'Pacemaker - AV paced',
    ),
    DropdownMenuItem(
      child: Text('Pacemaker - ventricular paced', style: kDropMenuItemStyle),
      value: 'Pacemaker - ventricular paced',
    ),
    DropdownMenuItem(
      child: Text('Second degree block type 1 (Wenckebach)',
          style: kDropMenuItemStyle),
      value: 'Second degree block type 1 (Wenckebach)',
    ),
    DropdownMenuItem(
      child: Text('Second degree block type 2', style: kDropMenuItemStyle),
      value: 'Second degree block type 2',
    ),
    DropdownMenuItem(
      child: Text('Sinus arrhythmia', style: kDropMenuItemStyle),
      value: 'Sinus arrhythmia',
    ),
    DropdownMenuItem(
      child: Text('Sinus bradycardia - SB', style: kDropMenuItemStyle),
      value: 'Sinus bradycardia - SB',
    ),
    DropdownMenuItem(
      child: Text('Sinus tachycardia - ST', style: kDropMenuItemStyle),
      value: 'Sinus tachycardia - ST',
    ),
    DropdownMenuItem(
      child:
          Text('Supraventricular tachycardia - SVT', style: kDropMenuItemStyle),
      value: 'Supraventricular tachycardia - SVT',
    ),
    DropdownMenuItem(
      child: Text('Third degree block (complete)', style: kDropMenuItemStyle),
      value: 'Third degree block (complete)',
    ),
    DropdownMenuItem(
      child: Text('Torsades De Pointes', style: kDropMenuItemStyle),
      value: 'Torsades De Pointes',
    ),
    DropdownMenuItem(
      child:
          Text('Ventricular fibrillation - V fib', style: kDropMenuItemStyle),
      value: 'Ventricular fibrillation - V fib',
    ),
    DropdownMenuItem(
      child:
          Text('Ventricular tachycardia - V tach', style: kDropMenuItemStyle),
      value: 'Ventricular tachycardia - V tach',
    ),
    DropdownMenuItem(
      child: Text('Wandering atrial pacemaker', style: kDropMenuItemStyle),
      value: 'Wandering atrial pacemaker',
    ),
  ];
}
