import 'package:flutter/material.dart';

const Map<String, dynamic> themeMap = {
  'Light': ThemeMode.light,
  'Dark': ThemeMode.dark,
  'System': ThemeMode.system
};


///For all settings
///[themeMode] ==> 0=light, 1=dark, 2=system
///
class Settings {
  Settings({required this.themeMode, required this.enableAutoSave});
  int themeMode;
  bool enableAutoSave;
  
  set setThemeMode(ThemeMode newThemeMode) {
    switch (newThemeMode) {
      case ThemeMode.light:
        themeMode = 0;
        break;
      case ThemeMode.dark:
        themeMode = 1;
        break;
      case ThemeMode.system:
        themeMode = 2;
        break;
    }
  }

  ThemeMode getThemeMode() {
    switch (themeMode) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
        return ThemeMode.system;
    }
    throw Exception('Set theme mode to 0,1,2');
  }

  Settings.fromJson(Map<String, dynamic> json)
      : themeMode = json['themeMode'],
        enableAutoSave = json['enableAutoSave'];

  Map<String, dynamic> toJson() =>
      {'themeMode': themeMode, 'enableAutoSave': enableAutoSave};
}
