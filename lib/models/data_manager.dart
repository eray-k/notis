import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:notis/models/settings.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

/// Save / Load Manager class.
class DataManager {
  //IMPLEMENT: Save/load each note seperately.
  Settings settings = Settings(themeMode: 1, enableAutoSave: true);
  List<Note> notes = List<Note>.empty(growable: true);
  static DataManager instance = DataManager();
  late final Directory mainDirectory;
  String dirPath = '';
  bool initialized = false;

  Future<String> init() async {
    if (initialized) return dirPath;

    if (kDebugMode) {
      print('Initializing Data Manager...');
    }
    initialized = true;
    final directory = await getApplicationDocumentsDirectory();
    mainDirectory = directory;
    dirPath = directory.path;
    await loadSettings();
    loadNotes();
    return directory.path;
  }

  File _localFile(String additionalPath) {
    final file = File('$dirPath/$additionalPath');
    if (!file.existsSync()) {
      if (kDebugMode) {
        print('Created file: ${file.path}');
      }
      file.create(recursive: true);
    }
    return file;
  }

  void saveSettings() async {
    final file = _localFile('settings.txt');
    await file.writeAsString(jsonEncode(settings));
  }

  ///Always
  Future<Settings> loadSettings() async {
    final file = _localFile('settings.txt');
    final encodedJson = await file.readAsString();
    if (encodedJson == "") {
      saveSettings();
    }
    final decodedJson = jsonDecode(encodedJson);
    try {
      settings = Settings(
          themeMode: decodedJson['themeMode'],
          enableAutoSave: decodedJson['enableAutoSave']);
    } catch (e) {
      if (kDebugMode) {
        print('Settings loaded model does not match. Using default model.');
      }
      saveSettings();
    }
    return settings;
  }

  Future<void> saveNote(Note note) async {
    final file = _localFile("${note.name}.md");
    await file.writeAsString(jsonEncode(note));
  }

  Future<List<Note>> loadNotes() async {
    final List<FileSystemEntity> entities = await mainDirectory.list().toList();
    final List<File> files = entities.whereType<File>().toList(growable: true);
    List<Note> notes = List.empty(growable: true);
    for (File e in files) {
      String fileName = e.path.split(Platform.pathSeparator).last;
      final int dotIndex = fileName.lastIndexOf('.');
      final fileExtension =
          (dotIndex != -1) ? fileName.substring(dotIndex) : '';
      if (fileExtension != '.md') {
        continue;
      }
      fileName = fileName.substring(0, dotIndex);
      notes.add(Note(name: fileName));
    }
    return notes;
  }

  Future<Note> loadNoteContent(Note note) async {
    final file = _localFile('${note.name}.md');
    final encodedJson = await file.readAsString();
    final decodedJson = jsonDecode(encodedJson);
    return Note(name: note.name, content: decodedJson['content']);
  }

  //#region DEBUG METHODS
  void debugPrintSettings() {
    if (kDebugMode) {
      print(
          'SETTINGS\n-----\nTheme: ${settings.getThemeMode()}\nAuto Save Enabled: ${settings.enableAutoSave}\n-----');
    }
  }
  //#endregion
}
