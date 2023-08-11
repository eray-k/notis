
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _ligthScheme,
  iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: MaterialStatePropertyAll(_ligthScheme.primary)))
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _darkScheme,
  iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: MaterialStatePropertyAll(_darkScheme.primary)))
);

ColorScheme _ligthScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF77b0ff),brightness: Brightness.light);
ColorScheme _darkScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF77b0ff),brightness: Brightness.dark);
