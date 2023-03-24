import 'dart:developer';

import 'package:acc_manager/cards/connectionCard.dart';
import 'package:acc_manager/cards/controlCard.dart';
import 'package:acc_manager/cards/enduranceCard.dart';
import 'package:acc_manager/cards/enduranceSessionsCard.dart';
import 'package:acc_manager/cards/previousSessionCard.dart';
import 'package:acc_manager/cards/sessionCard.dart';
import 'package:acc_manager/cards/settingsCard.dart';
import 'package:acc_manager/common/KeySettings.dart';

import 'package:acc_manager/constants/constants.dart';
import 'package:acc_manager/models/models.dart';
import 'package:acc_manager/pages/login_page.dart';
import 'package:acc_manager/pages/voiceTestPage.dart';
import 'package:acc_manager/pages/widgets/BGImages.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  late BuildContext context;
  HomePage(BuildContext ctx) {
    this.context = ctx;
    LocalStreams.context = ctx;
  }

  //Future<List<User>> users = UsersService.fromBase64("eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbmlhbWFrb3dza2FAZ21haWwuY29tIiwiZXhwIjoxNjAxMjE2MzcwLCJpYXQiOjE2MDExOTgzNzB9.DgMpti2AmWR82Q7X5hwBaBNe1vQcZEZmItSrJi-1pf4EcIJfqlxWf0cpVPzgMKHU3_siRYynNDstqfpSyeg3bw").getUsers();

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
    PopupChoices(title: 'Speech test', icon: Icons.voice_chat),
  ];

  @override
  Widget build(BuildContext context) {
    //this.context = context;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: Text("Assetto Corsa Manager"),
          actions: <Widget>[buildPopupMenu(context)],
        ),
        body: MyHomePage());
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == 'Log out') {
      //handleSignOut();
    } else if (choice.title == 'Speech test') {
      Navigator.push(this.context,
          MaterialPageRoute(builder: (context) => SpeechSampleApp()));
    } else {
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<PopupChoices>(
      onSelected: onItemMenuPress,
      itemBuilder: (BuildContext context) {
        return choices.map((PopupChoices choice) {
          return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: ColorConstants.primaryColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(color: ColorConstants.primaryColor),
                  ),
                ],
              ));
        }).toList();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isKeptOn = false;
  double _brightness = 1.0;
  Future<Map<String, KeySettings>>? _allKeys = conf.getAllKeys();
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    conf.getKey('SAVE RPLY').then((_kSave) => {sendKey(_kSave)});
    conf
        .getValueFromStore('autosave')
        .then((value) => sendAutoSaveActivity(value));

    conf.getValueFromStore('isKeptOn').then((value) => setWakelock(value));

    String _kOn = await conf.getServerSetting('isKeptOn');

    log('isKeptOn $_kOn');
    bool keptOn = _kOn == 'Y' ? true : false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage(getBGImage()),
                  alignment: FractionalOffset.centerRight,
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(12.0),
                  childAspectRatio: 8.0 / 4.0,
                  children: <Widget>[
                    // PhysicsCard(),
                    GraphicsCard(),
                    //MediaCard(),
                    SessionCard(),
                    SettingsCard(),
                    PreviousSessionCard(),
                    EnduranceCard(),
                    EnduranceSessionsCard(),
                  ],
                ),
              ),
              Expanded(flex: 1, child: ConnectionCard()),
              Expanded(
                flex: 2,
                child: Container(
                  width: 300.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(0.3))),
                    child: Text(
                      "SAVE DATA ON PC",
                      style: TextStyle(fontSize: 20, color: Colors.lightGreen),
                    ),
                    onPressed: _saveButtonPressed,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _saveButtonPressed() {
    RESTSessions.saveSessions().then((v) {
      print(v.body);
      _showAlert(v.body);
    });
  }

  _showAlert(String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(msg,
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
            ));
  }

  sendKey(KeySettings _kSave) {
    if (_kSave.key != '') {
      log('_kSave ${_kSave.key}');
      RESTSessions.setAutoSaveKey(_kSave.key);
    }
  }

  sendAutoSaveActivity(String value) {
    log('_autoSaveActivity');
    if (value != '') {
      RESTSessions.setAutoSaveActivity(value);
    }
  }

  setWakelock(String value) {
    if (value == 'Y')
      _isKeptOn = true;
    else
      _isKeptOn = false;

    if (_isKeptOn)
      Wakelock.enable();
    else
      Wakelock.disable();
  }
}
