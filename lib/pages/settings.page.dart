import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard/common/KeySettings.dart';
import 'package:virtual_keyboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  BuildContext context;
  SettingsPage(BuildContext ctx) {
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
        body: MySettingsPage());
  }
}

class MySettingsPage extends StatefulWidget {
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  Future<KeySettings> _lightsKey = conf.getKey('LIGHTS');
  Future<KeySettings> _mappKey = conf.getKey('MAP+');
  Future<KeySettings> _mapmKey = conf.getKey('MAP-');
  Future<Map<String,KeySettings>> _allKeys = conf.getAllKeys();
  final _lightsForm = GlobalKey<FormState>();
  final _mappForm = GlobalKey<FormState>();
  final _mapmForm = GlobalKey<FormState>();

  bool _lightsSaved = true;
  bool _mappSaved = true;
  bool _mapmSaved = true;

  final myControllerLIGHTS = TextEditingController();
  final myControllerMAPP = TextEditingController();
  final myControllerMAPM = TextEditingController();

  @override
  void initState() {
    setKeysOnStart();
    myControllerLIGHTS.addListener(_lightsLatestValue);
    myControllerMAPP.addListener(_mappLatestValue);
    myControllerMAPM.addListener(_mapmLatestValue);
  }

  setKeysOnStart() async {
    _allKeys.then((value) {
        myControllerLIGHTS.text = value['LIGHTS'].key;
        myControllerMAPP.text = value['MAP+'].key;
        myControllerMAPM.text = value['MAP-'].key;
    });

  }

  bool checkSaveNeed(KeySettings value) {
    bool state=false;
    switch (value.name) {
      case 'LIGHTS':
        if (myControllerLIGHTS.text == '') {
          state = true;
        } else {
          state = value.key == myControllerLIGHTS.text;
        }
        break;
      case 'MAP+':
        if (myControllerMAPP.text == '') {
          state = true;
        } else {
          state = value.key == myControllerMAPP.text;
        }
        break;
      case 'MAP-':
        if (myControllerMAPM.text == '') {
          state = true;
        } else {
          state = value.key == myControllerMAPM.text;
        }
        break;
    }
    return state;
  }

  _mapmLatestValue() {
    _mapmKey.then((value) => {
      setState ( () {
        _mapmSaved = checkSaveNeed(value);
      })
    });
  }
  _lightsLatestValue() {
    _lightsKey.then((value) => {
      setState ( () {
        _lightsSaved = checkSaveNeed(value);
      })
    });
  }
  _mappLatestValue() {
    _mappKey.then((value) => {
      setState ( () {
        _mappSaved = checkSaveNeed(value);
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("lib/assets/acc_3.jpg"),
                  alignment: FractionalOffset.topCenter,
                  fit: BoxFit.cover)),
          child: ListView(
            children: <Widget>[
                FutureBuilder<Map<String,KeySettings>>(
                    future: _allKeys,
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String,KeySettings>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            Map<String,KeySettings> all = snapshot.data;
                            var keyLight = all['LIGHTS'];
                            var keyMAPP = all['MAP+'];
                            var keyMAPM = all['MAP-'];
                            checkSaveNeed(keyLight);
                            checkSaveNeed(keyMAPP);
                            //myControllerLIGHTS.text = key.key;
                            //_lightsCurrentKey = key;
                            return Row(
                              children: [
                                Form(
                                  key: _lightsForm,
                                  child: Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_lightsForm.currentState.validate()) {
                                          keyLight.key = myControllerLIGHTS.text;
                                          conf.save(
                                              'LIGHTS', jsonEncode(keyLight.toJson()));
                                          setState(() {
                                            _lightsSaved = true;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        IconData(keyLight.codePoint,
                                            fontFamily: 'MaterialIcons'),
                                        color: _lightsSaved
                                            ? Colors.greenAccent
                                            : Colors.yellowAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: myControllerLIGHTS,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please a letter';
                                      }else {
                                          setState(() {
                                            _lightsSaved=checkSaveNeed(keyLight);
                                          });
                                      }
                                      return null;
                                    },
                                    style: GoogleFonts.comfortaa(
                                        textStyle: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900)),
                                    decoration: InputDecoration(
                                      fillColor: Colors.lightBlueAccent,
                                      labelText: keyLight.name,
                                      labelStyle: GoogleFonts.comfortaa(
                                          textStyle: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _mappForm,
                                  child: Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_mappForm.currentState.validate()) {
                                          keyMAPP.key = myControllerMAPP.text;
                                          conf.save(
                                              'MAP+', jsonEncode(all['MAP+'].toJson()));
                                          setState(() {
                                            _mappSaved = true;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        IconData(keyMAPP.codePoint,
                                            fontFamily: 'MaterialIcons'),
                                        color: _mappSaved
                                            ? Colors.greenAccent
                                            : Colors.yellowAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: myControllerMAPP,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please a letter';
                                      }else {
                                        setState(() {
                                          _mappSaved=checkSaveNeed(keyMAPP);
                                        });
                                      }
                                      return null;
                                    },
                                    style: GoogleFonts.comfortaa(
                                        textStyle: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900)),
                                    decoration: InputDecoration(
                                      fillColor: Colors.lightBlueAccent,
                                      labelText: keyMAPP.name,
                                      labelStyle: GoogleFonts.comfortaa(
                                          textStyle: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _mapmForm,
                                  child: Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_mapmForm.currentState.validate()) {
                                          keyMAPM.key = myControllerMAPM.text;
                                          conf.save(
                                              'MAP-', jsonEncode(all['MAP-'].toJson()));
                                          setState(() {
                                            _mapmSaved = true;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        IconData(keyMAPM.codePoint,
                                            fontFamily: 'MaterialIcons'),
                                        color: _mapmSaved
                                            ? Colors.greenAccent
                                            : Colors.yellowAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: myControllerMAPM,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please a letter';
                                      }else {
                                        setState(() {
                                          _mapmSaved=checkSaveNeed(keyMAPM);
                                        });
                                      }
                                      return null;
                                    },
                                    style: GoogleFonts.comfortaa(
                                        textStyle: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900)),
                                    decoration: InputDecoration(
                                      fillColor: Colors.lightBlueAccent,
                                      labelText: keyMAPM.name,
                                      labelStyle: GoogleFonts.comfortaa(
                                          textStyle: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      }
                    }),
            ],
          ),
        ));
  }
}
