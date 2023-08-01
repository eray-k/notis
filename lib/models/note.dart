import 'package:flutter/material.dart';

class Note {
  String name;
  String content;
  Note({required this.name, this.content = ''});

  @override
  String toString() {
    return '$name: $content';
  }
}

class NoteCardView extends StatelessWidget {
  const NoteCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: 75,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
            //TODO: Card Color
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Note',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                          'Lorem Ipsum aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            )),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(child: const Icon(Icons.info_outline)),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note Title')));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
