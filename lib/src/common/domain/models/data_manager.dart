import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:notis/src/common/domain/models/settings.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

/// Save / Load Manager class.
class DataManager {
  SettingsConfig settings = SettingsConfig(themeMode: 1, enableAutoSave: true);
  final Map<String, Note> _notes = {};
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
    _loadNotes();
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

  Future<SettingsConfig> loadSettings() async {
    final file = _localFile('settings.txt');
    final encodedJson = await file.readAsString();
    if (encodedJson == "") {
      saveSettings();
    }
    final decodedJson = jsonDecode(encodedJson);
    try {
      settings = SettingsConfig(
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

  ///- Saves note in json format with `***.md` extension
  ///- Adds to stack, DOES NOT OVERWRITE if [note.name] can't be found
  ///- Can be used to register empty note
  Future<void> saveNote(Note note) async {
    _notes[note.name] = note;
    final file = _localFile("${note.name}.md");
    await file.writeAsString(jsonEncode(note));
  }

  Future<void> deleteNote(String noteName) async {
    _notes.remove(noteName);
    final file = _localFile("$noteName.md");
    await file.delete();
  }

  Future<List<Note>> getNotes() async {
    if (_notes.isEmpty) {
      return await _loadNotes();
    } else {
      return _notes.values.toList();
    }
  }

  Future<List<Note>> _loadNotes() async {
    final List<FileSystemEntity> entities = await mainDirectory.list().toList();
    final List<File> files = entities.whereType<File>().toList(growable: true);
    for (File e in files) {
      String fileName = e.path.split(Platform.pathSeparator).last;
      final int dotIndex = fileName.lastIndexOf('.');
      final fileExtension =
          (dotIndex != -1) ? fileName.substring(dotIndex) : '';
      if (fileExtension != '.md') {
        continue;
      }
      fileName = fileName.substring(0, dotIndex);
      _notes[fileName] = Note(name: fileName);
    }
    return _notes.values.toList();
  }

  Future<Note> loadNoteContent(Note note) async {
    final file = _localFile('${note.name}.md');
    final encodedJson = await file.readAsString();
    final decodedJson = jsonDecode(encodedJson);
    note.content = decodedJson['content'];
    _notes[note.name] = note;
    return note;
  }

  //#region DEBUG METHODS
  void debugPrintSettings() {
    if (kDebugMode) {
      print(
          'SETTINGS\n-----\nTheme: ${settings.getThemeMode()}\nAuto Save Enabled: ${settings.enableAutoSave}\n-----');
    }
  }

  void debugPrintNotes() {
    if (kDebugMode) {
      print('${_notes.values}');
    }
  }
  //#endregion
}
