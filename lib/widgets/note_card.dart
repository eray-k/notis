import 'package:flutter/material.dart';
import 'package:notis/screens/note_edit.dart';

import '../models/note.dart';

class NoteCardView extends StatelessWidget {
  const NoteCardView({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {  
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: ListTile(
        title: Text(note.name),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        onTap: () {
          //Open note edit page
          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.of(context).push(routeBuilder());
          });
        },
        trailing:
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
      ),
    );
  }

  PageRouteBuilder<dynamic> routeBuilder() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => NoteEditPage(
        currentNote: note,
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
