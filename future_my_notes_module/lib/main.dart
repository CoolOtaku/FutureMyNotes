import 'package:flutter/material.dart';

import 'package:FutureMyNotes/pages/home.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.white,
        primaryColor: Colors.red[900],
        accentColor: Colors.white,
        backgroundColor: Colors.grey[850],
        scaffoldBackgroundColor: Colors.grey[850],
        hintColor: Colors.grey,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      title: "FutureMyNotes",
      initialRoute: '/',
      routes: {
        '/': (context) => Home()
      },
    )
  );
}
