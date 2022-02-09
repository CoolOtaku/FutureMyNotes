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
          hintColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
            headline6: TextStyle(),
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
