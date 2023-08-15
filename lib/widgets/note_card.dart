import 'package:flutter/material.dart';
import 'package:notis/models/temp.dart';
import 'package:notis/screens/note_edit.dart';

import '../models/note.dart';

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
                  Navigator.of(context).push(routeBuilder());
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
            : null,
      ),
    );
  }

  PageRouteBuilder<dynamic> routeBuilder() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => NoteEditPage(
        currentNote: widget.note,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
