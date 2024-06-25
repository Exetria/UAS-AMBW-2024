import 'package:flutter/material.dart';

Card noteCard(BuildContext context, String title, String content) {
  return Card(
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    ),
  );
}