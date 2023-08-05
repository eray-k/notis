import 'package:flutter/material.dart';
import 'package:notis/screens/home.dart';
import 'package:notis/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }
}

class MyAppState extends State<MyApp> {
  // #region Theme Variables
  ThemeMode _themeMode = ThemeMode.light;
  bool get isthemeLight {
    return _themeMode == ThemeMode.light;
  }

  void changeTheme(bool isLight) {
    setState(() {
      _themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void toggleTheme() {
    changeTheme(_themeMode == ThemeMode.dark);
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notis',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
