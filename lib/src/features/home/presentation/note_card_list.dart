import 'package:flutter/material.dart';
import 'package:notis/src/common/domain/models/data_manager.dart';
import 'package:notis/src/common/presentation/ui/widgets/note_card.dart';

import '../../../common/domain/models/note.dart';
import '../../../common/domain/models/temp.dart';

class NoteCardList extends StatefulWidget {
  const NoteCardList({super.key, required this.selectionModeChanged});
  final Function(bool) selectionModeChanged;
  @override
  State<NoteCardList> createState() => _NoteCardListState();
}

class _NoteCardListState extends State<NoteCardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: DataManager.instance.getNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return noteListView(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('Error!: ${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView noteListView(List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCardView(
          note: note,
          selectionCallback: (Note current, bool isSelected) {
            setState(() {
              if (Temp.selectedNotes.contains(current.name)) {
                //Unselect
                Temp.selectedNotes.remove(current.name);
              } else {
                //Select
                Temp.selectedNotes.add(current.name);
              }
              if (Temp.selectionMode != Temp.selectedNotes.isNotEmpty) {
                Temp.selectionMode = Temp.selectedNotes.isNotEmpty;
                widget.selectionModeChanged(Temp.selectionMode);
              }
            });
          },
        );
      },
    );
  }
}
