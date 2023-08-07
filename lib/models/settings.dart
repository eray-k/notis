import 'package:flutter/material.dart';

///For all settings
///[themeMode] ==> 0=light, 1=dark, 2=system
///
class Settings {
  //Delete themeMode
  Settings({
    int themeMode = 0,
  });
  int themeMode = 0;
  set setThemeMode(ThemeMode newThemeMode) {
    switch (newThemeMode) {
      case ThemeMode.light:
        themeMode = 0;
        return;
      case ThemeMode.dark:
        themeMode = 1;
        return;
      case ThemeMode.system:
        themeMode = 2;
        return;
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

  /// DO NOT use with [ThemeMode.system]
  void toggleThemeMode() {
    switch (themeMode) {
      case 0:
        themeMode = 1;
      case 1:
        themeMode = 0;
      case 2:
        themeMode = 2;
      default:
        throw Exception('Set theme mode to 0,1,2');
    }
  }

  Settings.fromJson(Map<String, dynamic> json) : themeMode = json['themeMode'];

  Map<String, dynamic> toJson() => {'themeMode': themeMode};
}
