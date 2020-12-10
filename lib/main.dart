import 'package:acc_manager/common/Configuration.dart';
import 'package:acc_manager/pages/login.page.dart';
import 'package:flutter/material.dart';

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


