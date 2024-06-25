// Buatlah sebuah note-taking app dengan media penyimpanan lokal menggunakan hive dengan syarat:

// 1. Di awal program selalu ditanya PIN untuk bisa mulai menggunakan aplikasi

// 2. Saat program pertama kali dipanggil akan diminta membuat PIN

// 3. Terdapat menu setting untuk mengganti PIN

// 4. Setiap note bisa di-edit, hapus, dan terdapat catatan tanggal dan jam kapan note dibuat dan terakhir di-edit

// Kumpulkan dengan cara: buat video presentasi yang menunjukkan kode, demo aplikasi, beserta penjelasannya. Tulis link video sebagai jawaban (boleh menggunakan YouTube Unlisted atau rekaman Gmeet/Zoom/OBS).

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