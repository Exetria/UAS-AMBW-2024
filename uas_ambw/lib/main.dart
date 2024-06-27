import 'package:flutter/material.dart';
import 'package:uas_ambw/login.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  //init hive
  Hive.initFlutter();

  //open box
  var box = Hive.openBox("notes");
  var pinBox = Hive.openBox("pin");
  var idBox = Hive.openBox("id");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS AMBW - C14210047',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}