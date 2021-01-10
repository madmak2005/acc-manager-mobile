import 'dart:convert';
import 'dart:developer';

import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/pages/widgets/BGImages.dart';
import 'package:acc_manager/pages/widgets/keyConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

final String img = getBGImage();

class SettingsPage extends StatelessWidget {
  BuildContext context;
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
  Future<Map<String,KeySettings>> _allKeys = conf.getAllKeys();
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState((){
      _isKeptOn = keptOn;
      _brightness = brightness;
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
                  colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                  fit: BoxFit.cover)),
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 5.0),
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
                              var keyMFD = all['MFD'];
                              var keyTCP = all['TC+'];
                              var keyTCM = all['TC-'];
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
                                          flex:1,
                                          child: new KeyConfig(keyLight),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyMAPP),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyMAPM),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: new KeyConfig(keyMFD),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyTCP),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyTCM),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: new KeyConfig(keyWipers),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyABSP),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyABSM),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyIGN),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: new KeyConfig(keyBBP),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(keyBBM),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: new KeyConfig(all['STARTER']),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Container(),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: new Column(
                                          children: <Widget>[
                                            new Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new Text("Screen is kept on? ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      backgroundColor: Colors.black38 )),
                                                  new Checkbox(value: _isKeptOn, onChanged: (bool b){
                                                    Screen.keepOn(b);
                                                    log('isKeptOn: ${jsonEncode(b)}');
                                                    conf.save("isKeptOn", jsonEncode(b));
                                                    setState((){_isKeptOn = b; });
                                                  })
                                                ]
                                            ),
                                            new Text("Brightness :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    backgroundColor: Colors.black38 )),
                                            new Slider(value : _brightness, onChanged : (double b){
                                              conf.save("brightness", jsonEncode(_brightness));
                                              setState((){_brightness = b;});
                                              Screen.setBrightness(b);
                                            })
                                          ]
                                      )
                                  ),
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

