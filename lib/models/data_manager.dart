import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notis/models/settings.dart';
import 'package:path_provider/path_provider.dart';

/// Save / Load Manager class.
class DataManager {
  //IMPLEMENT: Save/load each note seperately.
  Settings settings = Settings(themeMode: 1);

  static DataManager instance = DataManager();

  String path = '';
  bool initialized = false;

  Future<String> init() async {
    if (initialized) return path;

    if (kDebugMode) {
      print('Initializing Data Manager...');
    }
    initialized = true;
    final directory = await getApplicationDocumentsDirectory();
    path = directory.path;

    await loadSettings();

    return directory.path;
  }

  File _localFile(String additionalPath) {
    final file = File('$path/$additionalPath');
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
    settings = Settings(themeMode: decodedJson['themeMode']);
    return settings;
  }

  //#region DEBUG METHODS
  void debugPrintSettings() {
    final ThemeMode theme = settings.getThemeMode();
    if (kDebugMode) {
      print('-----\nTheme: $theme\n-----');
    }
  }
  //#end region
}
