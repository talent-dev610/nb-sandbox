class TodoClass {
  String? todoTitle;
  String? todoDesc;
  String? todoStart;
  String? todoFinish;
  String? todoFreq;
  String? todoRank;
  String? todoPt;
  String? todoCat;
  String? todoList;
  String? todoTag;
  bool? isCompleted;
  // id must not be final in order for index to be pushed to next screen
  String? id;
  String? ptId; // to connect task to specific patient
  String? publicPtValue; // public view of task to specific patient
  String? specialty; // to connect task to nursing specialty
  String? todoDate;
  int? reminderId;
  int? earlyReminderId;
  int? dateCreated;
  int? dateUpdated;
  bool? isReminder;
  int? reminderTime;
  int? exactDue;
  bool? isRepeatable;
  String? repeatationFrequency;
  String? repeatCount;
  String? completedRepeatCount;
  List? reminderIds;

  TodoClass({
    this.todoTitle,
    this.todoDesc,
    this.todoStart,
    this.todoFinish,
    this.todoFreq,
    this.todoRank,
    this.todoPt,
    this.todoCat,
    this.todoList,
    this.todoTag,
    this.isCompleted,
    this.id,
    this.ptId,
    this.publicPtValue,
    this.specialty,
    this.todoDate,
    this.reminderId,
    this.earlyReminderId,
    this.dateCreated,
    this.dateUpdated,
    this.isReminder,
    this.reminderTime,
    this.exactDue,
    this.isRepeatable,
    this.repeatationFrequency,
    this.repeatCount,
    this.completedRepeatCount,
    this.reminderIds,
  });

  TodoClass.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    ptId = map['ptId'] ?? '';
    publicPtValue = map['publicPtValue'] ?? '';
    specialty = map['specialty'] ?? '';
    todoTitle = map['todo_title'] ?? '';
    todoDesc = map['todo_desc'] ?? '';
    todoStart = map['todo_start'] ?? '';
    todoFinish = map['todo_finish'] ?? '';
    todoFreq = map['todo_freq'] ?? '';
    todoRank = map['todo_rank'] ?? '';
    todoPt = map['todo_pt'] ?? '';
    todoCat = map['todo_cat'] ?? '';
    todoList = map['todo_list'] ?? '';
    todoTag = map['todo_tag'] ?? '';
    isCompleted = map['is_completed'] ?? false;
    todoDate = map['todo_date'] ?? '';
    reminderId = map['reminderId'] ?? 0;
    earlyReminderId = map['early_reminder_id'] ?? 0;
    dateCreated = map['dateCreated'] ?? 0;
    dateUpdated = map['dateUpdated'] ?? 0;
    isReminder = map['isReminder'] ?? false;
    reminderTime = map['reminderTime'] ?? 0;
    exactDue = map['exactDue'] ?? 0;
    isRepeatable = map['is_repeatable'];
    repeatationFrequency = map['repeatation_frequency'];
    repeatCount = map['repeat_count'];
    completedRepeatCount = map['completed_repeat_count'];
    reminderIds = map['reminder_ids'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'ptId': ptId,
        'publicPtValue': publicPtValue,
        'specialty': specialty,
        'todo_title': todoTitle,
        'todo_desc': todoDesc,
        'todo_start': todoStart,
        'todo_finish': todoFinish,
        'todo_freq': todoFreq,
        'todo_rank': todoRank,
        'todo_pt': todoPt,
        'todo_cat': todoCat,
        'todo_list': todoList,
        'todo_tag': todoTag,
        'is_completed': isCompleted,
        'todo_date': todoDate,
        'reminderId': reminderId,
        'early_reminder_id': earlyReminderId,
        'dateCreated': dateCreated,
        'dateUpdated': dateUpdated,
        'isReminder': isReminder,
        'reminderTime': reminderTime,
        'exactDue': exactDue,
        'is_repeatable': isRepeatable,
        'repeatation_frequency': repeatationFrequency,
        'repeat_count': repeatCount,
        'completed_repeat_count': completedRepeatCount,
        'reminder_ids': reminderIds,
      };
}
