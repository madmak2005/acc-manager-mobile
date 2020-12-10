import 'dart:convert';

import 'package:acc_manager/common/KeySettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';



class KeyConfig extends StatefulWidget {
  KeySettings localKey;
  KeyConfig(KeySettings key) {
    this.localKey = key;
  }
  @override
  _KeyConfigState createState() => _KeyConfigState(localKey);
}

class _KeyConfigState extends State<KeyConfig> {
  KeySettings localKey;
  _KeyConfigState(KeySettings key){
    this.localKey = key;
  }
  final _form = GlobalKey<FormState>();
  bool _savedCheck = true;
  final myController = TextEditingController();

  @override
  void initState() {
    setKeysOnStart();
    myController.addListener(_setLatestValue);
  }

  setKeysOnStart() async {
      myController.text = localKey.key;
  }

  _setLatestValue() {
          setState(() {
            _savedCheck = checkSaveNeed(localKey);
          });
  }

  bool checkSaveNeed(KeySettings value) {
    bool state = false;
    if (myController.text == '') {
      state = true;
    } else {
      state = value.key == myController.text;
    }

    return state;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Form(
          key: _form,
          child: Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (_form.currentState.validate()) {
                  localKey.key = myController.text;
                  conf.save(localKey.name, jsonEncode(localKey.toJson()));
                  setState(() {
                    _savedCheck = true;
                  });
                }
              },
              child: Icon(
                localKey.toIconData(),
                color: _savedCheck ? Colors.greenAccent : Colors.yellowAccent,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: myController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a letter';
              } else {
                setState(() {
                  _savedCheck = checkSaveNeed(localKey);
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
              labelText: localKey.name,
              labelStyle: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
            ),
          ),
        )
      ],
    );
  }
}
