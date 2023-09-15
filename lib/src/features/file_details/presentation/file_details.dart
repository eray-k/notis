import 'package:flutter/material.dart';

class FileDetails extends StatefulWidget {
  const FileDetails({super.key});

  @override
  State<FileDetails> createState() => _FileDetailsState();
}

class _FileDetailsState extends State<FileDetails> {
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
