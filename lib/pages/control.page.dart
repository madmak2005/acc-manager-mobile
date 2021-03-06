import 'dart:convert';

import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/common/PageFileGraphics.dart';
import 'package:acc_manager/common/PageFilePhysics.dart';
import 'package:acc_manager/common/PageFileStatic.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/pages/widgets/Buttons.dart';
import 'package:acc_manager/pages/widgets/plusMinus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'login.page.dart';

class ControlPage extends StatelessWidget {
  final Map<String, KeySettings> keySetting;

  ControlPage(this.keySetting);

  @override
  Widget build(BuildContext context) {

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
          channelStatic: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
              'ws://${conf.serverIP}:${conf.serverPort}/acc/static'))
              : IOWebSocketChannel.connect(Uri.parse(
              'ws://${conf.serverIP}:${conf.serverPort}/acc/static')),
          keySetting: this.keySetting,
        ));
  }
}

class MyControlPage extends StatefulWidget {
  final WebSocketChannel channelGraphics, channelPhysics, channelStatic;
  final Map<String, KeySettings> keySetting;
  MyControlPage(
      {Key key, @required this.channelGraphics, @required this.channelPhysics, @required this.channelStatic, @required this.keySetting})
      : super(key: key);

  @override
  _MyControlPageState createState() => _MyControlPageState(this.keySetting);
}

class _MyControlPageState extends State<MyControlPage> {
  _MyControlPageState(this.keySetting);

  bool firstTimeGraphics = true;
  bool firstTimePhysics = true;
  bool firstTimeStatic = true;

  final Map<String, KeySettings> keySetting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: StreamBuilder(
            stream: widget.channelStatic.stream,
            builder: (context, snapshotStatic) {
              if (snapshotStatic.hasData) {
                if (firstTimeStatic) {
                  firstTimeStatic = false;
                }
                PageFileStatic ps = PageFileStatic.fromJson(
                    json.decode(snapshotStatic.data));
                return StreamBuilder(
                    stream: widget.channelPhysics.stream,
                    builder: (context, snapshotPhysics) {
                      if (snapshotPhysics.hasData) {
                        if (firstTimePhysics) {
                          widget.channelPhysics.sink.add('fuel,brakeBias');
                          firstTimePhysics = false;
                        }
                        PageFilePhysics pp =
                        PageFilePhysics.fromJson(
                            json.decode(snapshotPhysics.data));
                        return StreamBuilder(
                            stream: widget.channelGraphics.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (firstTimeGraphics) {
                                  widget.channelGraphics.sink.add(
                                      'packetId,isInPit,isInPitLane,TC,TCCut,EngineMap,ABS,fuelXLap,rainLights,flashingLights,lightsStage,wiperLV,normalizedCarPosition,lastSectorTime');
                                  firstTimeGraphics = false;
                                }
                                PageFileGraphics pg = PageFileGraphics.fromJson(
                                    json.decode(snapshot.data));

                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(flex: 1,
                                                  child: Lights(
                                                    pageFileGraphics: pg,)),
                                              pg.isInPit == 0
                                                  ? Expanded(
                                                  flex: 2,
                                                  child: PlusMinus(
                                                      (pg.engineMap + 1).toDouble(),
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
                                                      (pg.tc).toDouble(),
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
                                              Expanded(
                                                  flex: 1, child: Wipers(pg)),
                                              pg.isInPit == 0
                                                  ? Expanded(
                                                flex: 2,
                                                child: PlusMinus(
                                                    (pg.abs).toDouble(),
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
                                                Expanded(
                                                    flex: 1, child: Container()),
                                                pg.isInPit == 0
                                                    ? Expanded(
                                                    flex: 2,
                                                    child: PlusMinus(
                                                        pp.brakeBias,
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
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
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
                                                  DataCell(
                                                      Text('Track',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal))),
                                                  DataCell(Text(
                                                      (ps.track),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(
                                                      Text('Track position [%]',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal))),
                                                  DataCell(Text(
                                                      (pg.normalizedCarPosition *
                                                          100)
                                                          .toStringAsFixed(3),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(
                                                      Text('Last sector time [s]',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal))),
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
                                                      (pg.fuelXLap
                                                          .toStringAsFixed(3)),
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
                                                      (pp.fuel.toStringAsFixed(
                                                          3)),
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
                                return
                                  CircularProgressIndicator();
                              }
                            });
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 300,
                            width: 400,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const CircularProgressIndicator(),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        Consts.padding),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10.0,
                                        offset: const Offset(0.0, 10.0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        Consts.title,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Text(
                                          Consts.description,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                );
              } else {
                return
                  CircularProgressIndicator();
              }
            }
        ),
      ),
    );
  }




  @override
  void dispose() {
    widget.channelGraphics.sink.close();
    widget.channelPhysics.sink.close();
    super.dispose();
  }

}
