import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/PageFileGraphics.dart';
import 'package:virtual_keyboard/services/RESTVirtualKeyboard.dart';

import '../graphics.page.dart';

class ButtonWidget extends StatelessWidget {
  Icon icon;
  String action;
  ButtonWidget(Icon icon, String action) {
    this.icon = icon;
    this.action = action;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
          onTap: () => RESTVirtualKeyboard.sendkey(action), child: icon),
    );
  }
}

class Lights extends StatelessWidget {
  final PageFileGraphics pageFileGraphics;
  Lights({this.pageFileGraphics});

  Color getColor() {
    switch (pageFileGraphics.lightsStage) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.lightGreenAccent;
      case 2:
        return Colors.cyanAccent;
      default :
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "L I G H T S",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(keySetting['LIGHTS'].key);
              },
              child: Icon(keySetting['LIGHTS'].toIconData(),
                  size: 70.0, color: getColor()),
            ),
          ],
        ),
      ),
    );
  }
}

class MFD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "M F D",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(keySetting['MFD'].key);
              },
              child: Icon(keySetting['MFD'].toIconData(),
                  size: 70.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class Wipers extends StatelessWidget {
  final PageFileGraphics pageFileGraphics;
  Wipers(this.pageFileGraphics);

  Color getColor() {
    switch (pageFileGraphics.wiperLV) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.lightGreenAccent;
      case 2:
        return Colors.cyanAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          child: Column(
            children: [
              Text(
                "W I P E R S",
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              GestureDetector(
                onTap: () {
                  RESTVirtualKeyboard.sendkey(keySetting['WIPERS'].key);
                },
                child: Icon(keySetting['WIPERS'].toIconData(),
                    size: 70.0, color: getColor()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Ignition extends StatelessWidget {
  final PageFileGraphics pageFileGraphics;
  Ignition( {this.pageFileGraphics});

  Color getColor() {
    switch (pageFileGraphics.lightsStage) {
      case 0:
        return Colors.grey;
      default:
        return Colors.lightGreenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "I G N I T I O N",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(keySetting['IGNITION'].key);
              },
              child: Icon(keySetting['IGNITION'].toIconData(),
                  size: 70.0, color: getColor()),
            ),
          ],
        ),
      ),
    );
  }
}

class Starter extends StatelessWidget {
  final PageFileGraphics pageFileGraphics;
  Starter( {this.pageFileGraphics});

  Color getColor() {
    switch (pageFileGraphics.lightsStage) {
      case 0:
        return Colors.grey;
      default:
        return Colors.lightGreenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "S T A R T E R",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(keySetting['STARTER'].key);
              },
              child: Icon(keySetting['STARTER'].toIconData(),
                  size: 70.0, color: getColor()),
            ),
          ],
        ),
      ),
    );
  }
}