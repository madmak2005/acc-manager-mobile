import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/Configuration.dart';
import 'package:virtual_keyboard/pages/login.page.dart';

Configuration conf =  new Configuration();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACC Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}


