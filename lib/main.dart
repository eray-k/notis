import 'package:flutter/material.dart';
import 'package:notis/models/data_manager.dart';
import 'package:notis/screens/home.dart';
import 'package:notis/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  late final int _theme;
  _theme = prefs.getInt(
        'theme',
      ) ??
      0;

  runApp(MyApp(
    themeNo: _theme,
    prefs: prefs,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.themeNo, required this.prefs});
  final int themeNo;

  final SharedPreferences prefs;
  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }
}

class MyAppState extends State<MyApp> {
  late final DataManager dataManager;
  ThemeMode themeMode = ThemeMode.light;
  void toggleThemeMode() {
    setState(() {
      if (themeMode == ThemeMode.light) {
        themeMode = ThemeMode.dark;
        widget.prefs.setInt('theme', 1);
      } else if (themeMode == ThemeMode.dark) {
        themeMode = ThemeMode.light;
        widget.prefs.setInt('theme', 0);
      }
    });
  }

  @override
  void initState() {
    dataManager = DataManager.instance;
    if (widget.themeNo == 0) {
      themeMode = ThemeMode.light;
    } else if (widget.themeNo == 1) {
      themeMode = ThemeMode.dark;
    } else if (widget.themeNo == 2) {
      themeMode = ThemeMode.system;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notis',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
