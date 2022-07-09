
class ProfileModel {
  String? id;
  String? userName;
  String? userEmail;
  String? birthday;
  String? firstName;
  String? lastName;
  String? studentFlag;
  String? graduationDate;
  String? specialty;
  String? shiftLength;
  String? scheduleType;
  String? degree;
  List<String>? licenseList;
  List<String>? certificationsList;
  List<String>? hospitalList;
  List<String>? workStatusList;
  List<String>? startDateList;
  List<String>? endDateList;

  ProfileModel({
    this.id,
    this.userName,
    this.userEmail,
    this.birthday,
    this.firstName,
    this.lastName,
    this.studentFlag,
    this.graduationDate,
    this.specialty,
    this.shiftLength,
    this.scheduleType,
    this.degree,
    this.licenseList,
    this.certificationsList,
    this.hospitalList,
    this.workStatusList,
    this.startDateList,
    this.endDateList,
  });

  ProfileModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    userName = map['userName'] ?? '';
    userEmail = map['userEmail'] ?? '';
    birthday = map['birthday'] ?? '';
    firstName = map['firstName'] ?? '';
    lastName = map['lastName'] ?? '';
    studentFlag = map['studentFlag'];
    graduationDate = map['graduationDate'] ?? '';
    specialty = map['specialty'] ?? '';
    shiftLength = map['shiftLength'] ?? '';
    scheduleType = map['scheduleType'] ?? '';
    degree = map['degree'] ?? '';
    licenseList = List<String>.from(map['licenseList']);

    certificationsList = List<String>.from(map['certificationsList']);
    hospitalList = List<String>.from(map['hospitalList']);
    workStatusList = List<String>.from(map['workStatusList']);
    startDateList = List<String>.from(map['startDateList']);
    endDateList = List<String>.from(map['endDateList']);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userName': userName,
        'userEmail': userEmail,
        'birthday': birthday,
        'firstName': firstName,
        'lastName': lastName,
        'studentFlag':studentFlag,
        'graduationDate': graduationDate,
        'specialty': specialty,
        'shiftLength': shiftLength,
        'scheduleType': scheduleType,
        'degree': degree,
        'licenseList': licenseList,
        'certificationsList': certificationsList,
        'hospitalList': hospitalList,
        'workStatusList': workStatusList,
        'startDateList': startDateList,
        'endDateList': endDateList,
      };
}
