import 'package:flutter/material.dart';

// Lab Validation
enum LabValidation {
  low,
  high,
  normal,
}

// Lab Class
abstract class Lab {
  String? _labValue;
  String? _labName;
  String? _labRange;
  String? _labUnits;
  double? _minimum;
  double? _maximum;
  double? _minimumMale;
  double? _maximumMale;
  @required
  bool _specifyGender = false;
  bool _isPediatric = false;
  LabValidation? _validation;

  // getter method to publicly access private values of this class
  String? get name => _labName;
  String? get value => _labValue;
  String? get units => _labUnits;
  // get range based on gender
  String get range {
    return '(${_minimum.toString()} - ${_maximum.toString()} $_labUnits)';
  }

  // setter method to publicly set private values of this class
  set value(String? val) {
    // prevent doubles that begin with a decimal vs integer
    if (val != null && val.isNotEmpty && val[0] == '.') {
      val = '0' + val;
    }
    _labValue = val;
  }

  // Validation strings for error messages
  static dynamic _lowError = 'Below normal range!';
  static dynamic _highError = 'Above normal range!';

  // Validation methods for out of range values
  String? validateLab({dynamic value, String? gender}) {
    // for labs where default female range suffices
    if (gender == null || gender == 'Female' || _specifyGender == false) {
      // only parse correct characters
      if (value != null && value != '' && value != '.') {
        // convert string input to double
        value = double.parse(value);
        // validate to see if value is low
        if (value < _minimum) {
          _validation = LabValidation.low;
          return _lowError;
        }
        // validate to see if value is high
        else if (value > _maximum) {
          _validation = LabValidation.high;
          return _highError;
        }
      }
      // display normal range
      _validation = LabValidation.normal;
      _labRange =
          '(${_minimum.toString()} - ${_maximum.toString()} $_labUnits)';
      return _labRange;
    }
    // for labs where gender specificity is required
    else if (gender != 'Female') {
      if (value != null && value != '') {
        // convert string input to double
        value = double.parse(value);
        // validate to see if value is low
        if (value < _minimumMale) {
          _validation = LabValidation.low;
          return _lowError;
        }
        // validate to see if value is high
        else if (value > _maximumMale) {
          _validation = LabValidation.high;
          return _highError;
        }
      }
      // display normal range
      _validation = LabValidation.normal;
      _labRange =
          '(${_minimumMale.toString()} - ${_maximumMale.toString()} $_labUnits)';
      return _labRange;
    }
    return null;
  }

  // Change helper font color if lab value out of range
  TextStyle labHelperStyle() {
    if (_validation != LabValidation.normal) {
      return TextStyle(
        color: Colors.red[400],
      );
    } else
      return TextStyle(
          // color: Colors.grey[500],
          );
  }

  // Change clipboard font color if lab value out of range
  TextStyle clipboardLabStyle(value, gender) {
    // Determine if lab is within range
    validateLab(value: value, gender: gender);
    if (_validation != LabValidation.normal) {
      return TextStyle(
        color: Colors.red[400],
      );
    } else
      return TextStyle(
        color: Colors.blue[700],
      );
  }
}

// WBC
class LabWBC extends Lab {
  // default / female normal range
  final _minimum = 4;
  final _maximum = 10;

  @override
  String get _labName => 'WBC';
  String get _labUnits => 'K/uL';
}

// HGB
class LabHGB extends Lab {
  final _specifyGender = true;
  // female range
  final _minimum = 12;
  final _maximum = 16;
  // male range
  final _minimumMale = 14;
  final _maximumMale = 18;

  @override
  String get _labName => 'Hgb';
  String get _labUnits => 'g/dL';
}

// HCT
class LabHCT extends Lab {
  final _specifyGender = true;
  // female range
  final _minimum = 36;
  final _maximum = 45;
  // male range
  final _minimumMale = 42;
  final _maximumMale = 50;

  @override
  String get _labName => 'Hct';
  String get _labUnits => '%';
}

// PLT
class LabPLT extends Lab {
  // default / female normal range
  final _minimum = 150;
  final _maximum = 450;

  @override
  String get _labName => 'Plt';
  String get _labUnits => 'K/uL';
}

// Na+
class LabNA extends Lab {
  // default / female normal range
  final _minimum = 135;
  final _maximum = 145;

  @override
  String get _labName => 'Na+';
  String get _labUnits => 'mmol/L';
}

// K+
class LabK extends Lab {
  // default / female normal range
  final _minimum = 3.5;
  final _maximum = 5;

  @override
  String get _labName => 'K+';
  String get _labUnits => 'mmol/L';
}

// Cl-
class LabCL extends Lab {
  // default / female normal range
  final _minimum = 95;
  final _maximum = 105;

  @override
  String get _labName => 'Cl-';
  String get _labUnits => 'mmol/L';
}

// CO2
class LabCO2 extends Lab {
  // default / female normal range
  final _minimum = 23;
  final _maximum = 29;

  @override
  String get _labName => 'CO2';
  String get _labUnits => 'mEq/L';
}

// BUN
class LabBUN extends Lab {
  // default / female normal range
  final _minimum = 8;
  final _maximum = 23;

  @override
  String get _labName => 'BUN';
  String get _labUnits => 'mg/dL';
}

// Creat
class LabCREAT extends Lab {
  final _specifyGender = true;
  // female range
  final _minimum = 0.6;
  final _maximum = 1.1;
  // male range
  final _minimumMale = 0.9;
  final _maximumMale = 1.3;

  @override
  String get _labName => 'Creat';
  String get _labUnits => 'mg/dL';
}

// Glu
class LabGLU extends Lab {
  // default / female normal range
  final _minimum = 70;
  final _maximum = 110;

  @override
  String get _labName => 'Glu';
  String get _labUnits => 'mg/dL';
}

// Calc
class LabCALC extends Lab {
  // default / female normal range
  final _minimum = 8.5;
  final _maximum = 10.2;

  @override
  String get _labName => 'Ca';
  String get _labUnits => 'mg/dL';
}

// Mg
class LabMG extends Lab {
  // default / female normal range
  final _minimum = 1.5;
  final _maximum = 2;

  @override
  String get _labName => 'Mg';
  String get _labUnits => 'mEq/L';
}

// PO4
class LabPO4 extends Lab {
  // default / female normal range
  final _minimum = 3;
  final _maximum = 4.5;

  @override
  String get _labName => 'PO4';
  String get _labUnits => 'mg/dL';
}

// AST
class LabAST extends Lab {
  // default / female normal range
  final _minimum = 8;
  final _maximum = 48;

  @override
  String get _labName => 'AST';
  String get _labUnits => 'U/L';
}

// ALT
class LabALT extends Lab {
  // default / female normal range
  final _minimum = 7;
  final _maximum = 55;

  @override
  String get _labName => 'ALT';
  String get _labUnits => 'U/L';
}

// ALP
class LabALP extends Lab {
  // default / female normal range
  final _minimum = 40;
  final _maximum = 129;

  @override
  String get _labName => 'ALP';
  String get _labUnits => 'U/L';
}

// Bili
class LabBILI extends Lab {
  // default / female normal range
  final _minimum = 0.1;
  final _maximum = 1.2;

  @override
  String get _labName => 'Bili';
  String get _labUnits => 'mg/dL';
}

// PT
class LabPT extends Lab {
  // default / female normal range
  final _minimum = 11;
  final _maximum = 13.5;

  @override
  String get _labName => 'PT';
  String get _labUnits => 's';
}

// PTT
class LabPTT extends Lab {
  // default / female normal range
  final _minimum = 60;
  final _maximum = 70;

  @override
  String get _labName => 'PTT';
  String get _labUnits => 's';
}

// INR
class LabINR extends Lab {
  // default / female normal range
  final _minimum = 0.9;
  final _maximum = 1.2;

  @override
  String get _labName => 'INR';
  String get _labUnits => ''; // no units
}
