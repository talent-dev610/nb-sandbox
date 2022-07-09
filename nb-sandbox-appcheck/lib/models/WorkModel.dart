
class WorkModel {

  String? hospital;
  String? workStatus;
  String? startDate;
  String? endDate;

  WorkModel({
    this.hospital,
    this.workStatus,
    this.startDate,
    this.endDate,
  });

  WorkModel.fromMap(Map<String, dynamic> map) {
    hospital = map['hospital'] ?? '';
    workStatus = map['workStatus'] ?? '';
    startDate = map['startDate'] ?? '';
    endDate = map['endDate'] ?? '';
  }

  Map<String, dynamic> toMap() => {
    'hospital': hospital,
    'workStatus': workStatus,
    'startDate': startDate,
    'endDate': endDate,
  };
}
