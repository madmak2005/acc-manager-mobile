import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/common/PageFileGraphics.dart';
import 'package:acc_manager/common/PageFilePhysics.dart';
import 'package:acc_manager/pages/widgets/Buttons.dart';
import 'package:acc_manager/pages/widgets/plusMinus.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:acc_manager/main.dart';

Map<String, KeySettings> keySetting;
bool firstTimeGraphics,firstTimePhysics;

class ControlPage extends StatelessWidget {
  ControlPage(Map<String, KeySettings> k) {
    keySetting = k;
    firstTimeGraphics = true;
    firstTimePhysics = true;
  }
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        backgroundColor: Colors.black,
        body: MyControlPage(
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

class MyControlPage extends StatefulWidget {
  final WebSocketChannel channelGraphics, channelPhysics;
  MyControlPage(
      {Key key, @required this.channelGraphics, @required this.channelPhysics})
      : super(key: key);

  @override
  _MyControlPageState createState() => _MyControlPageState();
}

class _MyControlPageState extends State<MyControlPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: widget.channelPhysics.stream,
            builder: (context, snapshotPhysics) {
              if (snapshotPhysics.hasData) {
                if(firstTimePhysics) {
                  widget.channelPhysics.sink.add('fuel');
                  firstTimePhysics = false;
                }
                PageFilePhysics pp =
                    PageFilePhysics.fromJson(json.decode(snapshotPhysics.data));
                return StreamBuilder(
                    stream: widget.channelGraphics.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if(firstTimeGraphics) {
                          widget.channelGraphics.sink.add(
                              'packetId,isInPit,isInPitLane,TC,TCCut,EngineMap,ABS,fuelXLap,rainLights,flashingLights,lightsStage,wiperLV,normalizedCarPosition,lastSectorTime');
                          firstTimeGraphics = false;
                        }
                        PageFileGraphics pg = PageFileGraphics.fromJson(
                            json.decode(snapshot.data));

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(flex: 1, child: Lights(pageFileGraphics: pg,)),
                                      pg.isInPit == 0
                                          ? Expanded(
                                              flex: 2,
                                              child: PlusMinus(
                                                  pg.engineMap + 1,
                                                  'M A P',
                                                  Colors.yellow,
                                                  keySetting['MAP+'],
                                                  keySetting['MAP-']))
                                          : Expanded(
                                              flex: 2,
                                              child: Ignition(
                                                  pageFileGraphics: pg)),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(flex: 1, child: MFD()),
                                      pg.isInPit == 0
                                          ? Expanded(
                                              flex: 2,
                                              child: PlusMinus(
                                                  pg.tc,
                                                  'T C',
                                                  Colors.lightBlueAccent,
                                                  keySetting['TC+'],
                                                  keySetting['TC-']))
                                          : Expanded(
                                              flex: 2,
                                              child: Starter(
                                                pageFileGraphics: pg,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(flex: 1, child: Wipers(pg)),
                                      pg.isInPit == 0
                                          ? Expanded(
                                              flex: 2,
                                              child: PlusMinus(
                                                  pg.abs,
                                                  'A B S',
                                                  Colors.lightGreenAccent,
                                                  keySetting['ABS+'],
                                                  keySetting['ABS-']),
                                            )
                                          : Expanded(
                                              flex: 2,
                                              child: Container(),
                                            ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 12.0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(flex: 1, child: Container()),
                                        pg.isInPit == 0
                                            ? Expanded(
                                                flex: 2,
                                                child: PlusMinus(
                                                    pg.abs,
                                                    'B R A K E   B I A S',
                                                    Colors.lightGreen,
                                                    keySetting['BB+'],
                                                    keySetting['BB-']))
                                            : Expanded(
                                                flex: 2,
                                                child: Container(),
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
                                          DataCell(Text(
                                              (pp.fuel.toStringAsFixed(3)),
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
