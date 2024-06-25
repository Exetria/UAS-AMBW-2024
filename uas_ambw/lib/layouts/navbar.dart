import 'package:flutter/material.dart';
import 'package:uas_ambw/settings.dart';

PreferredSize navbar(context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Notes App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ],
        ),
      ),
    ),
  );
}
