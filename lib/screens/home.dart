import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notis/models/data_manager.dart';
import 'package:notis/models/temp.dart';
import 'package:notis/screens/settings_page.dart';
import 'package:notis/widgets/note_card_list.dart';

import '../models/note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notis',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        //Menu
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
          ),
          onPressed: () {
            //TODO: PopUp Slide Menu
          },
        ),

        //Settings
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: NoteCardList(
        selectionModeChanged: selectionModeChanged,
      ),
      floatingActionButton: Temp.selectionMode
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  for (var i = 0; i < Temp.selectedNotes.length; i++) {
                    DataManager.instance.deleteNote(Temp.selectedNotes[i]);
                  }
                  Temp.selectedNotes = List.empty(growable: true);
                  selectionModeChanged(false);
                });
              },
              child: const Icon(Icons.delete),
            )
          : FloatingActionButton(
              onPressed: () {
                final value = (Random().nextInt(9000) + 100).toString();
                final note = Note(name: value);
                setState(() {
                  DataManager.instance.saveNote(note);
                });
                DataManager.instance.saveNote(note);
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  selectionModeChanged(value) {
    setState(() {
      Temp.selectionMode = value;
    });
  }
}
