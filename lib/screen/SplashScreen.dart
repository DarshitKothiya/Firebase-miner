import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      Duration(milliseconds: 3000),
      () {
        Navigator.pushReplacementNamed(context, 'homepage');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://img.icons8.com/bubbles/2x/fa314a/notes-app.png',
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 50),
            Text(
              'Note App',
              style: GoogleFonts.habibi(fontSize: 25),
            ),
            const SizedBox(height: 150),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
