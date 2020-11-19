import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/KeySettings.dart';
import 'package:virtual_keyboard/common/PageFileGraphics.dart';
import 'package:virtual_keyboard/pages/widgets/plusMinus.dart';
import 'package:virtual_keyboard/services/RESTVirtualKeyboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:virtual_keyboard/main.dart';

Map<String, KeySettings> keySetting;

class GraphicsPage extends StatelessWidget {
  GraphicsPage(Map<String, KeySettings> k) {
    keySetting = k;
  }
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        backgroundColor: Colors.black,
        body: MyGraphicsPage(
          channel: kIsWeb ? WebSocketChannel.connect(Uri.parse('ws://${conf.serverIP}:${conf.serverPort}/acc/graphics')) : IOWebSocketChannel.connect(Uri.parse('ws://${conf.serverIP}:${conf.serverPort}/acc/graphics')),
        ));
  }
}

class MyGraphicsPage extends StatefulWidget {
  final WebSocketChannel channel;

  MyGraphicsPage({Key key, @required this.channel}) : super(key: key);

  @override
  _MyGraphicsPageState createState() => _MyGraphicsPageState();
}

class _MyGraphicsPageState extends State<MyGraphicsPage> {


  String getMapValue(PageFileGraphics pg) {
    return pg.engineMap.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PageFileGraphics pg =
                PageFileGraphics.fromJson(json.decode(snapshot.data));

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Lights(pg),
                            PlusMinus(pg.engineMap+1,'M A P', Colors.yellow, keySetting['MAP+'],keySetting['MAP-']),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MFD(pg),
                            PlusMinus(pg.tc,'T C', Colors.lightBlueAccent, keySetting['TC+'],keySetting['TC-']),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wipers(pg),
                            new PlusMinus(pg.abs,'A B S', Colors.lightGreenAccent, keySetting['ABS+'],keySetting['ABS-']),
                          ],
                        ),
                      ),
                    Text((pg.normalizedCarPosition * 100).toStringAsFixed(3) + ' %',
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                      Text((pg.lastSectorTime/1000).toString(),
                          style: TextStyle(color: Colors.white, fontSize: 24.0)),
                    ],
                  )
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}

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


class Lights extends StatelessWidget{
  PageFileGraphics pg;
  Lights(PageFileGraphics pageFileGraphics){
    pg = pageFileGraphics;
  }

  Color getLightColor(PageFileGraphics pg) {
    switch (pg.lightsStage) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.lightGreenAccent;
      case 2:
        return Colors.cyanAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "L I G H T S",
              style: TextStyle(
                  color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(
                    keySetting['LIGHTS'].key);
              },
              child: Icon(
                  IconData(keySetting['LIGHTS'].codePoint,
                      fontFamily: 'MaterialIcons'),
                  size: 90.0,
                  color: getLightColor(pg)),
            ),
          ],
        ),
      ),
    );
  }
}

class MFD extends StatelessWidget{
  PageFileGraphics pg;
  MFD(PageFileGraphics pageFileGraphics){
    pg = pageFileGraphics;
  }

  Color getColor(PageFileGraphics pg) {
    switch (pg.lightsStage) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.lightGreenAccent;
      case 2:
        return Colors.cyanAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "M F D",
              style: TextStyle(
                  color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(
                    keySetting['MFD'].key);
              },
              child: Icon(
                  IconData(keySetting['MFD'].codePoint,
                      fontFamily: 'MaterialIcons'),
                  size: 90.0,
                  color: getColor(pg)),
            ),
          ],
        ),
      ),
    );
  }
}

class Wipers extends StatelessWidget{
  PageFileGraphics pg;
  Wipers(PageFileGraphics pageFileGraphics){
    pg = pageFileGraphics;
  }

  Color getColor(PageFileGraphics pg) {
    switch (pg.wiperLV) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.lightGreenAccent;
      case 2:
        return Colors.cyanAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Container(
        child: Column(
          children: [
            Text(
              "W I P E R S",
              style: TextStyle(
                  color: Colors.white, fontSize: 24.0),
            ),
            GestureDetector(
              onTap: () {
                RESTVirtualKeyboard.sendkey(
                    keySetting['WIPERS'].key);
              },
              child: Icon(
                  IconData(keySetting['WIPERS'].codePoint,
                      fontFamily: 'MaterialIcons'),
                  size: 90.0,
                  color: getColor(pg)),
            ),
          ],
        ),
      ),
    );
  }
}
