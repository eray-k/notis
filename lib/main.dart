import 'package:flutter/material.dart';
import 'package:notis/src/features/home/presentation/home.dart';
import 'package:notis/src/common/common.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DataManager dataManager = DataManager.instance;
  await dataManager.init();
  final SettingsConfig settings = dataManager.settings;
  dataManager.debugPrintSettings();

  runApp(MyApp(
    settings: settings,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.settings});

  final SettingsConfig settings;
  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }
}

class MyAppState extends State<MyApp> {
  late final DataManager dataManager;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    setState(() {
      dataManager.settings.setThemeMode = themeMode;
      dataManager.saveSettings();
    });
  }

  @override
  void initState() {
    dataManager = DataManager.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notis',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: dataManager.settings.getThemeMode(),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
