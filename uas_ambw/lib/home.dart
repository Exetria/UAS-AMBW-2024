import 'package:flutter/material.dart';
import 'package:uas_ambw/add_note.dart';
import 'package:uas_ambw/settings.dart';
import 'package:uas_ambw/layouts/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box notesBox;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('notes');
    // Hive.box('notes').clear();
    // Hive.box('pin').clear();
    // Hive.box('id').clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.lightBlue,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No notes yet'),
            );
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;
                if (constraints.maxWidth >= 1200) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth >= 800) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth >= 600) {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: constraints.maxWidth * 0.02,
                    mainAxisSpacing: constraints.maxHeight * 0.02,
                    childAspectRatio: 1.0,
                  ),
                  padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final key = box.keyAt(index) as int;
                    final note = box.get(key) as List;
                    return noteCard(context, note);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddNote()), // Assuming you have an AddNotePage
          );
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      )
    );
  }
}
