import 'package:flutter/material.dart';

class FileOptionsView extends StatefulWidget {
  const FileOptionsView({super.key});

  @override
  State<FileOptionsView> createState() => _FileOptionsViewState();
}

class _FileOptionsViewState extends State<FileOptionsView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.amber,
        ),
      ),
    );
  }
}
