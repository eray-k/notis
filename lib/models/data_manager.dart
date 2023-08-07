import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notis/models/settings.dart';
import 'package:path_provider/path_provider.dart';

/// Save / Load Manager class.
class DataManager {
  //IMPLEMENT: Save/load each note seperately.
  Settings settings = Settings(themeMode: 0);

  static DataManager instance = DataManager();

  ThemeMode themeMode = ThemeMode.light;
  String path = '';
  bool initialized = false;
  Future<String> init() async {
    if (initialized) return path;
    initialized = true;
    final directory = await getApplicationDocumentsDirectory();
    path = directory.path;

    await loadSettings();

    return directory.path;
  }

  File _localFile(String additionalPath) {
    final file = File('$path/$additionalPath');
    if (file.existsSync()) file.create(recursive: true);
    return file;
  }

  void saveSettings() {
    final file = _localFile('settings.txt');
    print("Saving...");
    file.writeAsString(jsonEncode(settings));
  }

  ///Always
  Future<Settings> loadSettings() async {
    final file = _localFile('settings.txt');
    final encodedJson = await file.readAsString();
    if (encodedJson == "") saveSettings();
    final decodedJson = jsonDecode(encodedJson);
    settings = Settings(themeMode: decodedJson['themeMode']);
    print(settings);
    return settings;
  }

/*
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
*/
}
