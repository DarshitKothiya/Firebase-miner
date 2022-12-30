
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screen/SplashScreen.dart';
import 'package:note_keeper/screen/homepage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/': (context) => const SplashScreen(),
        'homepage': (context) => const Homepage(),
      },
    )
  );
}