class Nurse {
  String? id;
  String? nurseName;
  String? nurseDept;
  int? nurseShiftType;
  int? nurseShiftMonth;
  int? nurseShiftDay;
  int? nurseShiftHour;
  int? nurseShiftMinute;
  int? nurseLunch;
  int? nurseBreak1;
  int? nurseBreak2;
  int? nurseBreak3;
  int? nursePtMax;

  Nurse({
    this.id,
    this.nurseName,
    this.nurseDept,
    this.nurseShiftType,
    this.nurseShiftMonth,
    this.nurseShiftDay,
    this.nurseShiftHour,
    this.nurseShiftMinute,
    this.nurseLunch,
    this.nurseBreak1,
    this.nurseBreak2,
    this.nurseBreak3,
    this.nursePtMax,
  });

  Nurse.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    nurseName = map['nurse_name'] ?? '';
    nurseDept = map['nurse_dept'] ?? '';
    nurseShiftType = map['nurse_shift_type'] ?? -1;
    nurseShiftMonth = map['nurse_shift_month'] ?? -1;
    nurseShiftDay = map['nurse_shift_day'] ?? -1;
    nurseShiftHour = map['nurse_shift_hour'] ?? -1;
    nurseShiftMinute = map['nurse_shift_minute'] ?? -1;
    nurseLunch = map['nurse_lunch'] ?? -1;
    nurseBreak1 = map['nurse_break_1'] ?? -1;
    nurseBreak2 = map['nurse_break_2'] ?? -1;
    nurseBreak3 = map['nurse_break_3'] ?? -1;
    nursePtMax = map['nurse_pt_max'] ?? -1;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'nurse_name': nurseName,
        'nurse_dept': nurseDept,
        'nurse_shift_type': nurseShiftType,
        'nurse_shift_month': nurseShiftMonth,
        'nurse_shift_day': nurseShiftDay,
        'nurse_shift_hour': nurseShiftHour,
        'nurse_shift_minute': nurseShiftMinute,
        'nurse_lunch': nurseLunch,
        'nurse_break_1': nurseBreak1,
        'nurse_break_2': nurseBreak2,
        'nurse_break_3': nurseBreak3,
        'nurse_pt_max': nursePtMax,
      };
}
