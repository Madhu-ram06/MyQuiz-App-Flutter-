import 'package:flutter/material.dart';
import 'package:flutter_mentor_quiz_app_tut/home.dart';

import 'splash.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz  App',
      theme: ThemeData(
        primaryColor: Colors.purple[900],
      ),
      home: Home(),
    );
  }
}
