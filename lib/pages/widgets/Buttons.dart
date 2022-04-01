import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/common/PageFileGraphics.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Icon icon;
  final String action;
  ButtonWidget(this.icon, this.action);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
          onTap: () => RESTVirtualKeyboard.sendkey(action), child: icon),
    );
  }
}

class Lights extends StatelessWidget {
  final Future<Map<String, KeySettings>>? keySetting = conf.getAllKeys();
  final PageFileGraphics? pageFileGraphics;
  Lights({this.pageFileGraphics});

  Color getColor() {
    switch (pageFileGraphics!.lightsStage) {
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
    return FutureBuilder<Map<String, KeySettings>>(
        future: keySetting,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, KeySettings>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<String, KeySettings>? _allKeys = snapshot.data;
            return Container(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "L I G H T S",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        RESTVirtualKeyboard.sendkey(_allKeys!['LIGHTS']!.key);
                      },
                      child: Icon(_allKeys!['LIGHTS']!.toIconData(),
                          size: 70.0, color: getColor()),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class MFD extends StatelessWidget {
  final Future<Map<String, KeySettings>>? keySetting = conf.getAllKeys();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, KeySettings>>(
        future: keySetting,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, KeySettings>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<String, KeySettings>? _allKeys = snapshot.data;
            return Container(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "M F D",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        RESTVirtualKeyboard.sendkey(_allKeys!['MFD']!.key);
                      },
                      child: Container(
                        child: Icon(_allKeys!['MFD']!.toIconData(),
                            size: 70.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class Wipers extends StatelessWidget {
  final Future<Map<String, KeySettings>>? keySetting = conf.getAllKeys();

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
    return FutureBuilder<Map<String, KeySettings>>(
        future: keySetting,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, KeySettings>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<String, KeySettings>? _allKeys = snapshot.data;
            return Container(
                child: GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(_allKeys!['WIPERS']!.key);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "W I P E R S",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        Icon(_allKeys!['WIPERS']!.toIconData(),
                            size: 70.0, color: getColor()),
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
        });
  }
}

class Ignition extends StatelessWidget {
  final Future<Map<String, KeySettings>>? keySetting = conf.getAllKeys();
  final PageFileGraphics? pageFileGraphics;
  Ignition({this.pageFileGraphics});

  Color getColor() {
    switch (pageFileGraphics!.lightsStage) {
      case 0:
        return Colors.grey;
      default:
        return Colors.lightGreenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, KeySettings>>(
        future: keySetting,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, KeySettings>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<String, KeySettings>? _allKeys = snapshot.data;
            return Container(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "I G N I T I O N",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        RESTVirtualKeyboard.sendkey(_allKeys!['IGNITION']!.key);
                      },
                      child: Icon(_allKeys!['IGNITION']!.toIconData(),
                          size: 70.0, color: getColor()),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class Starter extends StatelessWidget {
  final Future<Map<String, KeySettings>>? keySetting = conf.getAllKeys();
  final PageFileGraphics? pageFileGraphics;
  Starter({this.pageFileGraphics});

  Color getColor() {
    switch (pageFileGraphics!.lightsStage) {
      case 0:
        return Colors.grey;
      default:
        return Colors.lightGreenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, KeySettings>>(
        future: keySetting,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, KeySettings>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<String, KeySettings>? _allKeys = snapshot.data;
            return Container(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "S T A R T E R",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        RESTVirtualKeyboard.sendkey(_allKeys!['STARTER']!.key);
                      },
                      child: Icon(_allKeys!['STARTER']!.toIconData(),
                          size: 70.0, color: getColor()),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
