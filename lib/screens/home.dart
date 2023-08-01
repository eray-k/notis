import 'package:flutter/material.dart';
import 'package:notis/models/Note.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notis',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        body: ListView.separated(
          itemCount: 15,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) {
            return const NoteCardView();
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 72.0),
              child: Divider(),
            );
          },
        ));
  }
}
