import 'package:flutter/material.dart';
import 'package:notis/src/common/domain/models/temp.dart';
import 'package:notis/src/features/editor/presentation/editor.dart';
import 'package:notis/src/features/file_details/presentation/file_details.dart';

import '../../../domain/models/note.dart';
import '../../../constants/utils.dart';

class NoteCardView extends StatefulWidget {
  const NoteCardView({
    super.key,
    required this.note,
    required this.selectionCallback,
  });
  final Note note;
  final Function(Note, bool) selectionCallback;
  @override
  State<NoteCardView> createState() => _NoteCardViewState();
}

class _NoteCardViewState extends State<NoteCardView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: ListTile(
        title: Text(widget.note.name),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        onTap: Temp.selectionMode
            ? () {
                setState(() {
                  widget.selectionCallback(widget.note,
                      Temp.selectedNotes.contains(widget.note.name));
                });
              }
            : () {
                //Open note edit page
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.of(context).push(slideInAnim(NoteEditPage(
                    currentNote: widget.note,
                  )));
                });
              },
        onLongPress: Temp.selectionMode
            ? null
            : () {
                setState(() {
                  widget.selectionCallback(widget.note,
                      Temp.selectedNotes.contains(widget.note.name));
                });
              },
        trailing: Temp.selectionMode
            ? Checkbox(
                onChanged: null,
                value: Temp.selectedNotes.contains(widget.note.name),
              )
            : IconButton(
                onPressed: () {
                  Navigator.of(context).push(slideInAnim(const FileDetails()));
                },
                icon: const Icon(Icons.more_horiz)),
      ),
    );
  }
}
