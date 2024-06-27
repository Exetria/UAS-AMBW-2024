import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_ambw/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uas_ambw/layouts/navbar.dart';

class EditNote extends StatefulWidget {
  final List note;

  const EditNote({super.key, required this.note});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> saveNote(BuildContext context) async {
    final box = await Hive.openBox('notes');

    final DateTime newDate = DateTime.now();
    final int id = widget.note[4];

    box.put(id, [
      titleController.text,
      contentController.text,
      widget.note[2],
      newDate,
      id
    ]);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  Future<void> deleteNote(BuildContext context) async {
    final box = await Hive.openBox('notes');

    final int id = widget.note[4];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Delete This Note?'),
              content: Column(mainAxisSize: MainAxisSize.min, children: []),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {
                    box.delete(id);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text("Yes"),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Edit Note",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                'Created: ${formatter.format(widget.note[2])}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 2.0),
              Text(
                'Last updated: ${formatter.format(widget.note[3])}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: titleController..text = widget.note[0],
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: contentController..text = widget.note[1],
                maxLines: 15,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            deleteNote(context);
          },
          tooltip: 'Delete',
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
        ),
        SizedBox(
          width: 16,
        ),
        FloatingActionButton(
          onPressed: () {
            saveNote(context);
          },
          tooltip: 'Save',
          child: Icon(Icons.save),
        ),
      ]),
    );
  }
}
