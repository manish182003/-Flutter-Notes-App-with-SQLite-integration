class Notes {
  int? id;
  String title;
  String data;

  Notes({
    this.id,
    required this.title,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'data': data,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      data: map['data'] ?? '',
    );
  }
}
