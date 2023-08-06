import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key, required this.currentNote});
  final Note currentNote;
  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.currentNote.content;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentNote.name),
        centerTitle: true,
      ),
      body: TextField(
        controller: _controller,
        //style: TextStyle(),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        showCursor: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.text =
                "a\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\n";
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
