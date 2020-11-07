import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/Configuration.dart';
import 'package:virtual_keyboard/pages/home.page.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACC Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(context),
    );
  }
}


