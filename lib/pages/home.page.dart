import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/cards/graphicsCard.dart';
import 'package:virtual_keyboard/cards/mediaCard.dart';
import 'package:virtual_keyboard/cards/physicsCard.dart';
import 'package:virtual_keyboard/cards/settingsCard.dart';
import 'package:virtual_keyboard/pages/settings.page.dart';

class HomePage extends StatelessWidget {
  BuildContext context;
  HomePage(BuildContext ctx) {
    context = ctx;
  }

  //Future<List<User>> users = UsersService.fromBase64("eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbmlhbWFrb3dza2FAZ21haWwuY29tIiwiZXhwIjoxNjAxMjE2MzcwLCJpYXQiOjE2MDExOTgzNzB9.DgMpti2AmWR82Q7X5hwBaBNe1vQcZEZmItSrJi-1pf4EcIJfqlxWf0cpVPzgMKHU3_siRYynNDstqfpSyeg3bw").getUsers();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: Text("Assetto Corsa Manager"),
        ),
        body: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("lib/assets/acc_1.jpg"),
                  alignment: FractionalOffset.centerRight,
                  fit: BoxFit.cover)),
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(12.0),
            childAspectRatio: 8.0 / 4.0,
            children: <Widget>[
              PhysicsCard(),
              GraphicsCard(),
              MediaCard(),
              SettingsCard(),
            ],
          ),
        ));
  }
}
