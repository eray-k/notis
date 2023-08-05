import 'dart:io';

import 'package:notis/models/note.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

/// Save / Load Manager class.
class DataManager {
  //IMPLEMENT: Save/load each note seperately.

  static DataManager instance = DataManager();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  Future<File> writeNotes(NoteList noteList) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(noteList));
  }

  Future<NoteList> readNotes() async {
    final file = await _localFile;
    final encodedJson = await file.readAsString();
    final Map<String, dynamic> decodedJson = jsonDecode(encodedJson);
    List<dynamic> decodedNotes = decodedJson['notes'];
    decodedNotes.map((e) => jsonDecode(e));
    List<Note> notes = List.empty(growable: true);
    for (var e in decodedNotes) {
      notes.add(Note(name: e['name'], content: e['content']));
    }
    return NoteList(notes);
  }
}
