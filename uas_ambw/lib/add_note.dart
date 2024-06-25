import 'package:flutter/material.dart';
import 'package:uas_ambw/home.dart';
import 'package:uas_ambw/layouts/navbar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNote();
}

class _AddNote extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> saveNote(BuildContext context) async
  {
    final box = await Hive.openBox('notes');
    final idBox = await Hive.openBox('id');

    if(idBox.get(0) == null)
    {
      idBox.put(0, 0);
    }
    
    final int nextId = idBox.get(0);

    box.put(nextId, [titleController.text, contentController.text, DateTime.now(), contentController.text, DateTime.now()]);
    idBox.put(0, nextId+1);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navbar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 20,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.02),
              child: ElevatedButton(
                onPressed: () {
                  saveNote(context);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                ),
                child: Text(
                  'Save Note',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
