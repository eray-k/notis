import 'package:flutter/material.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        centerTitle: true,
      ),
      body: const TextEditView(),
    );
  }
}

class TextEditView extends StatefulWidget {
  const TextEditView({super.key});

  @override
  State<TextEditView> createState() => _TextEditViewState();
}

class _TextEditViewState extends State<TextEditView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
