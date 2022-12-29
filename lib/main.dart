import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screen/AuthorCrud.dart';
import 'package:login_app/screen/AuthorPage.dart';
import 'package:login_app/screen/Homepage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => const Homepage(),
        'author_page':(context) => const AuthorPage(),
        'author_crud':(context) => const AuthorCrud(),
      },
    )
  );
}

