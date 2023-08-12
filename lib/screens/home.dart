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
  }

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
          //TODO: Theme goes to settings screen and settings button replaces here
          IconButton(
              onPressed: () {
                setState(() {
                  MyApp.of(context).toggleThemeMode();
                });
              },
              icon: Icon(dataManager.settings.getThemeMode() == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode))
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: dataManager.loadNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return noteListView(snapshot.data ?? List.empty());
          } else if (snapshot.hasError) {
            return Text('Error!: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataManager.saveNote(Note(name: 'aaa'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView noteListView(List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return NoteCardView(note: notes[index]);
      },
    );
  }
}
