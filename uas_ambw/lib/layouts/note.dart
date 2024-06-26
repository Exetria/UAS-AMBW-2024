import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_ambw/edit_note.dart';

GestureDetector noteCard(BuildContext context, List note) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

  String formatDate(DateTime target) {
    return formatter.format(target);
  }

  return GestureDetector(
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditNote(note: note)), // Assuming you have an EditNotePage
      );
    },
    child: Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note[0],
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  "Last Updated: ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  formatDate(note[3]),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              note[1],
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 5,
            ),
          ],
        ),
      ),
    ),
  );
}
