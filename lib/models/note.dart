/// Main Note model
// ignore_for_file: file_names

class Note {
  String name;
  String content;
  Note({required this.name, this.content = ''});

  @override
  String toString() {
    return '$name: $content';
  }

  Note.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'content': content,
      };
}

class NoteList {
  final List<Note> notes;

  NoteList(this.notes);

  NoteList.fromJson(Map<String, dynamic> json) : notes = json['notes'];

  Map<String, dynamic> toJson() => {
        'notes': notes,
      };
}
