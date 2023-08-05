import 'package:flutter/material.dart';
import 'package:notis/main.dart';
import 'package:notis/models/data_manager.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final DataManager dataManager;
  @override
  void initState() {
    super.initState();
    dataManager = DataManager.instance;
    dataManager.readNotes().then((value) {
      setState(() {
        notes = value.notes;
      });
    });
  }

  List<Note> notes = List.empty(growable: true);

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
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            //TODO: PopUp Slide Menu
          },
        ),
        
        //Settings
        actions: [
          //TODO: Theme goes to settings screen and settings button replaces here
          IconButton(
              onPressed: () {
                MyApp.of(context).toggleTheme();
              },
              icon: Icon(MyApp.of(context).isthemeLight
                  ? Icons.light_mode
                  : Icons.dark_mode))
        ],
      ),
      body: noteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataManager.writeNotes(NoteList(notes));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView noteListView() {
    return ListView.separated(
      itemCount: notes.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return NoteCardView(note: notes[index]);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          indent: 24,
          endIndent: 96,
        );
      },
    );
  }
}
