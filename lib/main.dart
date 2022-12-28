
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screen/authorpage.dart';
import 'package:note_keeper/screen/homepage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Homepage(),
        'author_page': (context) => const AuthorPage(),
      },
    )
  );
}