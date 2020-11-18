import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/KeySettings.dart';
import 'package:virtual_keyboard/common/PageFileGraphics.dart';
import 'package:virtual_keyboard/services/RESTVirtualKeyboard.dart';

class PlusMinus extends StatelessWidget{
  int value;
  String title;
  KeySettings keySettingsPlus, keySettingsMinus;
  Color color;

  PlusMinus(int value, String title, Color color, KeySettings keySettingsPlus, KeySettings keySettingsMinus){
    this.value = value;
    this.title = title;
    this.color = color;
    this.keySettingsPlus = keySettingsPlus;
    this.keySettingsMinus = keySettingsMinus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 24.0),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  RESTVirtualKeyboard.sendkey(
                      keySettingsPlus.key);
                },
                child: Icon(
                    IconData(keySettingsPlus.codePoint,
                        fontFamily: 'MaterialIcons'),
                    size: 90.0,
                    color: color),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                    color: Colors.white, fontSize: 48.0),
              ),
              GestureDetector(
                onTap: () {
                  RESTVirtualKeyboard.sendkey(
                      keySettingsMinus.key);
                },
                child: Icon(
                    IconData(keySettingsMinus.codePoint,
                        fontFamily: 'MaterialIcons'),
                    size: 90.0,
                    color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}