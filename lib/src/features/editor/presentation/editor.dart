import 'package:flutter/material.dart';
import 'package:notis/src/common/domain/models/data_manager.dart';
import 'package:notis/src/common/constants/utils.dart' as util;

import '../../../common/domain/models/note.dart';

enum SaveStatus { done, ongoing, changed }

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key, required this.currentNote});
  final Note currentNote;
  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController _controller = TextEditingController();
  late final DataManager _dataManager;
  SaveStatus saveStatus = SaveStatus.done;
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
          onPressed: saveStatus != SaveStatus.ongoing
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
            if (saveStatus == SaveStatus.done)
              const Icon(Icons.check)
            else if (saveStatus == SaveStatus.ongoing)
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              )
            else
              const Icon(Icons.mode_edit)
          ],
        ),
        centerTitle: true,
      ),
      body: TextField(
        controller: _controller,
        onChanged: (val) {
          setState(() {
            saveStatus = (_dataManager.settings.enableAutoSave)
                ? SaveStatus.ongoing
                : SaveStatus.changed;
          });
          if (!_dataManager.settings.enableAutoSave) return;
          widget.currentNote.content = _controller.text;
          util.debounce(const Duration(seconds: 1), 'save-note', () async {
            await _dataManager.saveNote(widget.currentNote);
            try {
              setState(() {
                saveStatus = SaveStatus.done;
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
      floatingActionButton: _dataManager.settings.enableAutoSave
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  saveStatus = SaveStatus.ongoing;
                });
                widget.currentNote.content = _controller.text;
                _dataManager.saveNote(widget.currentNote).then(
                  (value) {
                    setState(() {
                      saveStatus = SaveStatus.done;
                    });
                  },
                );
              },
              child: const Icon(Icons.save),
            ),
    );
  }
}
