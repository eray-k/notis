import 'package:flutter/material.dart';
import 'package:notis/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006C4B)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
