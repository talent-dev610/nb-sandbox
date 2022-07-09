class NoteModel {
  String? id;
  String? title;
  String? category;
  String? body;
  String? created_date;
  String? last_date;

  NoteModel({
    this.id,
    this.title,
    this.category,
    this.body,
    this.created_date,
    this.last_date,
  });

  NoteModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    title = map['title'] ?? '';
    category = map['category'] ?? '';
    body = map['body'] ?? '';
    created_date = map['created_date'] ?? '';
    last_date = map['last_date'] ?? '';
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'category': category,
    'body': body,
    'created_date': created_date,
    'last_date': last_date,
  };
}
