import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/common/PageFileGraphics.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PlusMinus extends StatelessWidget {
  int value;
  String title;
  KeySettings keySettingsPlus, keySettingsMinus;
  Color color;

  PlusMinus(int value, String title, Color color, KeySettings keySettingsPlus,
      KeySettings keySettingsMinus) {
    this.value = value;
    this.title = title;
    this.color = color;
    this.keySettingsPlus = keySettingsPlus;
    this.keySettingsMinus = keySettingsMinus;
  }

  //Future<List<User>> users = UsersService.fromBase64("eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbmlhbWFrb3dza2FAZ21haWwuY29tIiwiZXhwIjoxNjAxMjE2MzcwLCJpYXQiOjE2MDExOTgzNzB9.DgMpti2AmWR82Q7X5hwBaBNe1vQcZEZmItSrJi-1pf4EcIJfqlxWf0cpVPzgMKHU3_siRYynNDstqfpSyeg3bw").getUsers();

  @override
  Widget build(BuildContext context) {
    return PlusMinusWidget(color: this.color, title: this.title,value: this.value,keySettingsMinus: this.keySettingsMinus,keySettingsPlus: keySettingsPlus);
  }
}

class PlusMinusWidget extends StatefulWidget {
  final int value;
  final String title;
  final KeySettings keySettingsPlus, keySettingsMinus;
  final Color color;

 PlusMinusWidget({Key key, @required this.value, @required this.title, @required this.keySettingsPlus, @required this.keySettingsMinus, @required this.color}) : super(key: key);

  @override
  _PlusMinusState createState() => _PlusMinusState(value,  title,  color,  keySettingsPlus, keySettingsMinus);

}

class _PlusMinusState extends State<PlusMinusWidget> {
  int value;
  String title;
  KeySettings keySettingsPlus, keySettingsMinus;
  Color color;
  _PlusMinusState(int value, String title, Color color, KeySettings keySettingsPlus,
      KeySettings keySettingsMinus){
    this.value = value;
    this.title = title;
    this.color = color;
    this.keySettingsPlus = keySettingsPlus;
    this.keySettingsMinus = keySettingsMinus;
    var ico  = Icon(Ionicons.ios_search);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  RESTVirtualKeyboard.sendkey(widget.keySettingsPlus.key);
                },
                child: Icon(
                    widget.keySettingsPlus.toIconData(),
                    size: 70.0,
                    color: widget.color),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
                child: Text(
                  widget.value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 32.0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  RESTVirtualKeyboard.sendkey(widget.keySettingsMinus.key);
                },
                child: Icon(
                    widget.keySettingsMinus.toIconData(),
                    size: 70.0,
                    color: widget.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
