import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/KeySettings.dart';
import 'package:virtual_keyboard/common/PageFileGraphics.dart';
import 'package:virtual_keyboard/common/PageFilePhysics.dart';
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
          channelGraphics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/graphics'))
              : IOWebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/graphics')),
          channelPhysics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/physics'))
              : IOWebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/physics')),
        ));
  }
}

class MyGraphicsPage extends StatefulWidget {
  final WebSocketChannel channelGraphics, channelPhysics;
  MyGraphicsPage(
      {Key key, @required this.channelGraphics, @required this.channelPhysics})
      : super(key: key);

  @override
  _MyGraphicsPageState createState() => _MyGraphicsPageState();
}

class _MyGraphicsPageState extends State<MyGraphicsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: widget.channelPhysics.stream,
            builder: (context, snapshotPhysics) {
              if (snapshotPhysics.hasData) {
                PageFilePhysics pp =
                    PageFilePhysics.fromJson(json.decode(snapshotPhysics.data));
                return StreamBuilder(
                    stream: widget.channelGraphics.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        PageFileGraphics pg = PageFileGraphics.fromJson(
                            json.decode(snapshot.data));

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(
                                    flex:1,
                                    child:Lights(pg)),
                                      pg.isInPit == 0
                                          ? Expanded(
                                          flex:2,
                                          child:PlusMinus(
                                              pg.engineMap + 1,
                                              'M A P',
                                              Colors.yellow,
                                              keySetting['MAP+'],
                                              keySetting['MAP-']))
                                          : Expanded(
                                        flex:2,
                                        child:Container()),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(
                                    flex:1,
                                    child:MFD(pg)
                                    ),
                                  Expanded(
                                    flex:2,
                                    child:PlusMinus(
                                          pg.tc,
                                          'T C',
                                          Colors.lightBlueAccent,
                                          keySetting['TC+'],
                                          keySetting['TC-'])
                                  ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex:1,
                                          child: Wipers(pg)),
                                      Expanded(
                                        flex:2,
                                        child: PlusMinus(
                                            pg.abs,
                                            'A B S',
                                            Colors.lightGreenAccent,
                                            keySetting['ABS+'],
                                            keySetting['ABS-']),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,12.0,0,0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                      Expanded(
                                      flex:1,
                                      child:Container()),
                                    Expanded(
                                      flex:2,
                                      child:PlusMinus(
                                            pg.abs,
                                            'B R A K E   B I A S',
                                            Colors.lightGreen,
                                            keySetting['BB+'],
                                            keySetting['BB-'])
                                    ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 20, 5, 10),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    color: Colors.white10,
                                    child: DataTable(
                                      dataRowHeight: 16.0,
                                      columns: [
                                        DataColumn(
                                            label: Text('Data',
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        DataColumn(
                                            label: Text('Value',
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text('Track position [%]',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal))),
                                          DataCell(Text(
                                              (pg.normalizedCarPosition * 100)
                                                  .toStringAsFixed(3),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal))),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Last sector time [s]',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal))),
                                          DataCell(Text(
                                              (pg.lastSectorTime / 1000)
                                                  .toStringAsFixed(3),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal))),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text(
                                              'Avg fuel consumed [l/lap]',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal))),
                                          DataCell(Text(
                                              (pg.fuelXLap.toStringAsFixed(3)),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal))),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Fuel [kg]',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.normal))),
                                          DataCell(Text((pp.fuel.toStringAsFixed(3)),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.normal))),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  @override
  void dispose() {
    widget.channelGraphics.sink.close();
    widget.channelPhysics.sink.close();
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

class Lights extends StatelessWidget {
  PageFileGraphics pg;
  Lights(PageFileGraphics pageFileGraphics) {
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
                  size: 70.0, color: getLightColor(pg)),
            ),
          ],
        ),
      ),
    );
  }
}

class MFD extends StatelessWidget {
  PageFileGraphics pg;
  MFD(PageFileGraphics pageFileGraphics) {
    pg = pageFileGraphics;
  }

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
  PageFileGraphics pg;
  Wipers(PageFileGraphics pageFileGraphics) {
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
                    size: 70.0, color: getColor(pg)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
