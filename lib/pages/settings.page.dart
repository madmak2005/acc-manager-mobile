import 'dart:convert';
import 'dart:developer';

import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/pages/widgets/BGImages.dart';
import 'package:acc_manager/pages/widgets/keyConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

final String img = getBGImage();

class SettingsPage extends StatelessWidget {
  BuildContext? context;
  SettingsPage(BuildContext ctx) {
    context = ctx;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: Text("Configuration page"),
        ),
        body: MySettingsPage());
  }
}

class MySettingsPage extends StatefulWidget {
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  Future<Map<String, KeySettings>>? _allKeys = conf.getAllKeys();
  bool _isKeptOn = false;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool keptOn = true;
    setState(() {
      _isKeptOn = keptOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage(img),
                  alignment: FractionalOffset.topCenter,
                  colorFilter:
                      ColorFilter.mode(Colors.black87, BlendMode.darken),
                  fit: BoxFit.cover)),
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 5.0),
            child: ListView(
              children: <Widget>[
                FutureBuilder<Map<String, KeySettings>>(
                    future: _allKeys,
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, KeySettings>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            Map<String, KeySettings> all = snapshot.data!;
                            var keyLight = all['LIGHTS'];
                            var keyMAPP = all['MAP+'];
                            var keyMAPM = all['MAP-'];
                            var keyMFD = all['MFD'];
                            var keyTCP = all['TC+'];
                            var keyTCM = all['TC-'];
                            var keyTC2P = all['TC2+'];
                            var keyTC2M = all['TC2-'];
                            var keyABSP = all['ABS+'];
                            var keyABSM = all['ABS-'];
                            var keyWipers = all['WIPERS'];
                            var keyBBP = all['BB+'];
                            var keyBBM = all['BB-'];
                            var keyIGN = all['IGNITION'];
                            return Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyLight!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyMAPP!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyMAPM!),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyTCP!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyTCM!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyTC2P!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyTC2M!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyWipers!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyABSP!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyABSM!),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyIGN!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyBBP!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyBBM!),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(all['STARTER']!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: new KeyConfig(keyMFD!),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: new Column(children: <Widget>[
                                  new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("Screen is kept on? ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                backgroundColor:
                                                    Colors.black38)),
                                        new Checkbox(
                                            value: _isKeptOn,
                                            onChanged: (bool? b) {
                                              b!
                                                  ? Wakelock.enable()
                                                  : Wakelock.disable();
                                              log('isKeptOn: ${jsonEncode(b)}');
                                              conf.save(
                                                  "isKeptOn", jsonEncode(b));
                                              setState(() {
                                                _isKeptOn = b;
                                              });
                                            })
                                      ]),
                                ])),
                              ],
                            );
                          }
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
