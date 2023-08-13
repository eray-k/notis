import 'package:flutter/material.dart';
import 'package:notis/models/data_manager.dart';
import 'package:notis/util/util.dart' as util;

import '../models/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key, required this.currentNote});
  final Note currentNote;
  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController _controller = TextEditingController();
  late final DataManager _dataManager;
  bool saved = true;
  @override
  void initState() {
    _dataManager = DataManager.instance;
    _dataManager.loadNoteContent(widget.currentNote).then((value) {
      _controller.value = TextEditingValue(
        text: value.content,
        selection: TextSelection.fromPosition(
            TextPosition(offset: value.content.length)),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.currentNote.content = _controller.text;
    _dataManager.saveNote(widget.currentNote);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: saved
              ? () {
                  Navigator.pop(context);
                }
              : null,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //TODO: Center title, not row
            Text(widget.currentNote.name),
            const SizedBox(width: 4),
            saved
                ? const Icon(Icons.check)
                : SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
          ],
        ),
        centerTitle: true,
      ),
      body: TextField(
        controller: _controller,
        onChanged: (val) {
          setState(() {
            saved = false;
          });
          if (!_dataManager.settings.enableAutoSave) return;
          widget.currentNote.content = _controller.text;
          util.debounce(const Duration(seconds: 1), 'save-note', () async {
            await _dataManager.saveNote(widget.currentNote);
            try {
              setState(() {
                saved = true;
              });
            } catch (e) {}
          });
        },
        //style: TextStyle(),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        showCursor: true,
        autofocus: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          widget.currentNote.content = _controller.text;
          await _dataManager.saveNote(widget.currentNote);
          saved = true;
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
